## Module site web

### Exemple d'utilisation

```
module "website" {
    source = "github.com/Flemax/terraform-module-aws-website"
    providers = {
        aws.us = aws.us-east-1,
        aws.eu = aws.eu-west-1
    }
    domain_name = "infopix.fr"
    enable_index_file_in_bucket = true
    tags = {
        tag1 = "tag1"
        tag2 = "tag2"
        tag3 = "tag3"
    }
}
```

### Description

> :warning: **Ce module nécessite qu'il existe déjà une zone d'hébèrgement route53**

Ce module permet de créer un site web avec un nom de domaine et va créer les ressources suivantes:

- S3
- CloudFront
- Certificat Manager
- Route53

Version courante : v1.0

### Utilisation
Lors de la déclaration du module, ajouter la source : 
````
source = "git::ssh://bitbucket.org/tigf_bitbucket/terraform-mod-aws-website.git?ref=vx.x"
````
Préciser la version voulue en remplaçant vx.x.

### Arguments obligatoires

|Nom|Type|Description|
|:-----:|:-:|:-------------|
|domain_name|string|Nom de domaine|
|tags|map(string)|Tags obligatoires|  

### Providers obligatoires

|Nom|Type|Description|
|:-----:|:-:|:-------------|
|aws.us|provider|Provider us-east-1|
|aws.eu|provider|Provider de votre projet|

### Arguments facultatifs

|Nom|Type|Description|
|:-----:|:-:|:-------------|
|enable_index_file_in_bucket|bool|Mettre à 'true' pour avoir un fichier index.html de Work In Progress|

### Sortie

|Nom|Type|Description|
|:-----:|:-:|:-------------|
|bucket|resource|Bucket créé|
|certificat|resource|Certificat créé|
|cdn|resource|Distribution CloudFront créé|
|route|resource|Route créé|


### Log

- v1.0 : Première version