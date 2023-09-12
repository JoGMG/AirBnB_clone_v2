#!/usr/bin/python3
""" A python script that generates and distributes a .tgz archive using Fabric. """
import os
from fabric.api import env, put, run

""" Host server IP addresses to execute script """
env.hosts = ["34.202.159.210", "54.90.4.252"]

def do_deploy(archive_path):
    """Distributes the archived file to the host servers.
    Argument:
        archive_path (str): The path to the archived file.
    """
    if not os.path.exists(archive_path):
        return False
    file_name = os.path.basename(archive_path)
    folder_name = file_name.replace(".tgz", "")
    folder_path = "/data/web_static/releases/{}/".format(folder_name)
    try:
        put(archive_path, "/tmp/")
        run("mkdir -p {}".format(folder_path))
        run("tar -xzf /tmp/{} -C {}".format(file_name, folder_path))
        run("rm /tmp/{}".format(file_name))
        run("mv {}/web_static/* {}".format(folder_path, folder_path))
        run("rm -rf {}/web_static".format(folder_path))
        run("rm -rf /data/web_static/current")
        run("ln -s {} /data/web_static/current".format(folder_path))
        print('New version deployed!')
        return True
    except Exception:
        return False
