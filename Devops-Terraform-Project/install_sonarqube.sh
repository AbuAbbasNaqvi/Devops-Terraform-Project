#!/bin/bash
    # Update packages
    sudo apt update -y
    sudo apt upgrade -y

    # Install PostgreSQL
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null
    sudo apt update
    sudo apt-get -y install postgresql postgresql-contrib
    sudo systemctl enable postgresql

    # Create Database for SonarQube
    sudo passwd postgres
    sudo -u postgres createuser sonar
    sudo -u postgres psql -c "ALTER USER sonar WITH ENCRYPTED PASSWORD 'sonar';"
    sudo -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;"

    # Install Java (Adoptium/Temurin)
    sudo wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
    sudo apt update
    sudo apt install temurin-17-jdk -y

    # Linux Kernel Tuning
    echo "sonarqube - nofile 65536" | sudo tee -a /etc/security/limits.conf
    echo "sonarqube - nproc 4097" | sudo tee -a /etc/security/limits.conf
    echo "vm.max_map_count = 262144" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p

    # Download and Install SonarQube
    cd /opt
    sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip
    sudo apt install unzip -y
    sudo unzip sonarqube-9.9.0.65466.zip
    sudo mv sonarqube-9.9.0.65466 sonarqube

    # Set Permissions
    sudo groupadd sonar
    sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar
    sudo chown sonar:sonar /opt/sonarqube -R

    # Update SonarQube Configuration
    sudo sed -i 's/#sonar.jdbc.username=/sonar.jdbc.username=sonar/' /opt/sonarqube/conf/sonar.properties
    sudo sed -i 's/#sonar.jdbc.password=/sonar.jdbc.password=sonar/' /opt/sonarqube/conf/sonar.properties
    sudo sed -i 's/#sonar.jdbc.url=jdbc:postgresql:\/\/localhost:5432\/sonarqube/sonar.jdbc.url=jdbc:postgresql:\/\/localhost:5432\/sonarqube/' /opt/sonarqube/conf/sonar.properties

    # Create SonarQube service
    echo "[Unit]
    Description=SonarQube service
    After=syslog.target network.target

    [Service]
    Type=forking
    ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
    ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
    User=sonar
    Group=sonar
    Restart=always
    LimitNOFILE=65536
    LimitNPROC=4096

    [Install]
    WantedBy=multi-user.target" | sudo tee /etc/systemd/system/sonar.service

    # Start and Enable SonarQube service
    sudo systemctl daemon-reload
    sudo systemctl start sonar
    sudo systemctl enable sonar

    # Monitor logs
    tail -f /opt/sonarqube/logs/sonar.log