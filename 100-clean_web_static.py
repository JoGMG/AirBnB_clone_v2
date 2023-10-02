#!/usr/bin/python3
"""
A python script that generates and distributes a .tgz
archive, and clean out-dated archive files using Fabric.
"""
import os
from datetime import datetime
from fabric.api import env, local, put, run

""" Remote webservers detail to execute script """
env.hosts = ["34.202.159.210", "54.90.4.252"]
env.user = "ubuntu"
env.key_filename = "~/.ssh/alx_sevkey"


def do_pack():
    """ Generates a .tgz archive from the contents of web_static folder. """
    if not os.path.isdir("versions"):
        os.mkdir("versions")
    cur_time = datetime.now()
    output = "versions/web_static_{}{}{}{}{}{}.tgz".format(
        cur_time.year,
        cur_time.month,
        cur_time.day,
        cur_time.hour,
        cur_time.minute,
        cur_time.second
    )
    try:
        print("Packing web_static to {}".format(output))
        local("tar -cvzf {} web_static".format(output))
        archize_size = os.stat(output).st_size
        print("web_static packed: {} -> {} Bytes".format(output, archize_size))
        return output
    except Exception:
        return None


def do_deploy(archive_path):
    """
    Distributes the archived file to the host servers.
        - Argument:
            - archive_path: The path to the archived file.
    """
    if not os.path.exists(archive_path):
        return False
    try:
        file_name = os.path.basename(archive_path)
        folder_name = file_name.replace(".tgz", "")
        folder_path = "/data/web_static/releases/{}/".format(folder_name)
        put(archive_path, "/tmp/")
        run("mkdir -p {}".format(folder_path))
        run("tar -xzf /tmp/{} -C {}".format(file_name, folder_path))
        run("rm /tmp/{}".format(file_name))
        run("mv {}/web_static/* {}".format(folder_path, folder_path))
        run("rm -rf {}/web_static".format(folder_path))
        run("rm -rf /data/web_static/current")
        run("ln -s {} /data/web_static/current".format(folder_path))
        print("New version deployed!")
        return True
    except Exception:
        return False


def deploy():
    """
    Generates archive and distribute files to remote webservers.
    """
    archive_path = do_pack()
    return do_deploy(archive_path) if archive_path else False


def do_clean(number=0):
    """Deletes out-of-date archives.
    Argument:
        number: The number of archives to keep.
    """
    archives = os.listdir('versions/')
    archives.sort(reverse=True)
    path = '/data/web_static/releases/'
    start = int(number)
    if not start:
        start += 1
    if start < len(archives):
        archives = archives[start:]
    else:
        archives = []

    # Delete out-dated archives
    for archive in archives:
        os.unlink('versions/{}'.format(archive))

    # Delete all out-dated archives remotely
    run("find {} -maxdepth 1 -name 'web_static*' -type d | sort -r \
        | tr '\n' ' ' | cut -d ' ' -f {}- | xargs rm -rf"
        .format(path, start + 1))

    print('Cleaning finished successfully')
