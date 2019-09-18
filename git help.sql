总结:其实只需要进行下面几步就能把本地项目上传到Github

1,在本地创建一个版本库（即文件夹），通过git init把它变成Git仓库；



2、把项目复制到这个文件夹里面，再通过git add .把项目添加到仓库；


3、再通过git commit -m "注释内容"把项目提交到仓库；


4、在Github上设置好SSH密钥后，新建一个远程仓库，通过git remote add origin?https://github.com/anky07/sqlcode.git将本地仓库和远程仓库进行关联；


5、最后通过git push -u origin master把本地仓库的项目推送到远程仓库（也就是Github）上；
由于新建的远程仓库是空的，所以要加上-u这个参数，等远程仓库里面有了内容之后，下次再从本地库上传内容的时候只需下面这样就可以了：git push origin master

（若新建远程仓库的时候自动创建了README文件会报错，解决办法看上面）。



这里只是总结了Git上传项目的一些基本操作，要想更好地使用Git还需更进一步的学习。