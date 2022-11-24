# Cómo subir actualizaciones a GitHub

* Eliminamos la carpeta */public*
* Añadir cambios
```git
git add -A
```

* Commit
```git
git commit -m "mensaje informativo"
```

* Push
```git
git push origin master
```

* Reactivamos el submodulo */public*
```git
git submodule add -f -b master https://github.com/somiedo/somiedo.github.io.git public
```

* Cargamos de nuevo la carpeta public
```git
hugo
```

* Entramos en */public*
```git
cd .\public\
```

* Añadimos los cambios de */public*
```git
git add -A
```

* Commit
```git
git commit -m "mensaje informativo"
```

* Push (main) No hace falta
```git
git pull --rebase
```
```git
git push origin master
```