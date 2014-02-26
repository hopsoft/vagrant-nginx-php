# Vagrant setup for running PHP scripts

Note: PHP scripts are served with Nginx on port 8000.

## Usage

### 1. Start the box

```
git clone https://github.com/hopsoft/vagrant-nginx-php.git
cd vagrant-nginx-php
mkdir php_scripts
vagrant up
```

### 2. Write some PHP

```
echo "<?php echo 'Hello, world...\n'; ?>" > php_scripts/hello_world.php
```

### 3. View the result

```
curl http://localhost:8000/hello_world.php
```
