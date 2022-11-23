---
title: Carga de datos en R
subtitle: Realizamos la importación de los datos con los que luego trabajaremos

# Summary for listings and search engines
summary: Vamos a importar nuestros datos de trabajo, y lo haremos de varias formas para poder llevarlo a cabo en diferentes situaciones

# Link this post with a project
projects: []

# Date published
date: "2022-02-23T00:00:00Z"

# Date updated
lastmod: "2022-02-23T19:14:00Z"

# Is this an unpublished draft?
draft: false

# Show this page in the Featured widget?
featured: false

# Featured image
# Place an image named `featured.jpg/png` in this page's folder and customize its options here.
image:
  #caption: 'Image credit: [**Unsplash**](https://unsplash.com/photos/CpkOjOcXdUY)'
  focal_point: ""
  placement: 2
  preview_only: false

authors:
- admin

tags:
 - RStudio, data

categories:
- R
---





Indicamos el directorio de trabajo




## Carga de datos desde RStudio

Son paquetes de datos utilizados tan frecuentemente que RStudio ya los incorpora


```r
data(iris)
head(iris)
```

{
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Sepal.Length"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["Sepal.Width"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["Petal.Length"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Petal.Width"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["Species"],"name":[5],"type":["fctr"],"align":["left"]}],"data":[{"1":"5.1","2":"3.5","3":"1.4","4":"0.2","5":"setosa","_rn_":"1"},{"1":"4.9","2":"3.0","3":"1.4","4":"0.2","5":"setosa","_rn_":"2"},{"1":"4.7","2":"3.2","3":"1.3","4":"0.2","5":"setosa","_rn_":"3"},{"1":"4.6","2":"3.1","3":"1.5","4":"0.2","5":"setosa","_rn_":"4"},{"1":"5.0","2":"3.6","3":"1.4","4":"0.2","5":"setosa","_rn_":"5"},{"1":"5.4","2":"3.9","3":"1.7","4":"0.4","5":"setosa","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
}










## Carga desde un archivo csv

Podemos tener el archivo de datos en local (/data/Iris.csv)


```r
iris_local <- read.csv(file="data/Iris.csv", 
                       header=TRUE, # cabecera
                       sep = ",", # separador de campos
                       na.strings="", # tratamiento de na
                       stringsAsFactors=FALSE) # tratamiento de factores

head(iris_local)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Id"],"name":[1],"type":["int"],"align":["right"]},{"label":["SepalLengthCm"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["SepalWidthCm"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["PetalLengthCm"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["PetalWidthCm"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["Species"],"name":[6],"type":["chr"],"align":["left"]}],"data":[{"1":"1","2":"5.1","3":"3.5","4":"1.4","5":"0.2","6":"Iris-setosa","_rn_":"1"},{"1":"2","2":"4.9","3":"3.0","4":"1.4","5":"0.2","6":"Iris-setosa","_rn_":"2"},{"1":"3","2":"4.7","3":"3.2","4":"1.3","5":"0.2","6":"Iris-setosa","_rn_":"3"},{"1":"4","2":"4.6","3":"3.1","4":"1.5","5":"0.2","6":"Iris-setosa","_rn_":"4"},{"1":"5","2":"5.0","3":"3.6","4":"1.4","5":"0.2","6":"Iris-setosa","_rn_":"5"},{"1":"6","2":"5.4","3":"3.9","4":"1.7","5":"0.4","6":"Iris-setosa","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

## Carga desde una url


```r
# Desde GitHub nos aseguramos la forma Raw
iris_url <- read.csv(file="https://raw.githubusercontent.com/somiedo/Apuntes_R/main/data/Iris.csv")
head(iris_url)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Id"],"name":[1],"type":["int"],"align":["right"]},{"label":["SepalLengthCm"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["SepalWidthCm"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["PetalLengthCm"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["PetalWidthCm"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["Species"],"name":[6],"type":["chr"],"align":["left"]}],"data":[{"1":"1","2":"5.1","3":"3.5","4":"1.4","5":"0.2","6":"Iris-setosa","_rn_":"1"},{"1":"2","2":"4.9","3":"3.0","4":"1.4","5":"0.2","6":"Iris-setosa","_rn_":"2"},{"1":"3","2":"4.7","3":"3.2","4":"1.3","5":"0.2","6":"Iris-setosa","_rn_":"3"},{"1":"4","2":"4.6","3":"3.1","4":"1.5","5":"0.2","6":"Iris-setosa","_rn_":"4"},{"1":"5","2":"5.0","3":"3.6","4":"1.4","5":"0.2","6":"Iris-setosa","_rn_":"5"},{"1":"6","2":"5.4","3":"3.9","4":"1.7","5":"0.4","6":"Iris-setosa","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

## Parámetros de ***read.csv()***

Ahora nos fijaremos en los parámetros que podemos utilizar con la función ***read.csv()***

* *header=TRUE*: nos indica si el fichero incorpora cabecera

* *sep = ","*: para indicar el caracter separador de campos

* *na.strings=""*: para indicar qué valor consideramos como *NA*

* *stringsAsFactors=FALSE*: para indicar si los campos de tipo caracter los consideramos como *factor*









