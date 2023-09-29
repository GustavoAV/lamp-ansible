# LAMP Ansible Role

Ansible project to setup a standard LAMP (Linux, Apache, MySQL, PHP) stack.

## Development

We use the tools below for this project development. Install and configure them following the documentations steps.

- [Ansible](https://docs.ansible.com/)
- [Molecule](https://ansible.readthedocs.io/projects/molecule/)
- [Virtual Box](https://www.virtualbox.org/wiki/Documentation)
- [Vagrant](https://developer.hashicorp.com/vagrant/docs)

And then, run:

```bash
molecule converge
```

This creates and configure a LAMP webserver. You can acess the links below to confirm everything is running properly:

- LAMP in Ubuntu 20.04: <http://localhost:8020>
- LAMP in Ubuntu 22.04: <http://localhost:8022>

To destroy and remove the VMs, simply run:

```bash
molecule destroy
```

## References

- [Ansible examples repo](https://github.com/ansible/ansible-examples.git)
- [LAMP setup Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04)
