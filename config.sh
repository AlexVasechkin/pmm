#!/bin/bash
pmm-admin config --server-insecure-tls --server-url=https://admin:123456@mon_pmm-server:443
pmm-admin add mysql local_db mon_db:3306 --username=root --password= --query-source=perfschema
