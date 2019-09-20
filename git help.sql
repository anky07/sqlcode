总结:其实只需要进行下面几步就能把本地项目上传到Github

1,在本地创建一个版本库（即文件夹），通过git init把它变成Git仓库；



2、把项目复制到这个文件夹里面，再通过git add .把项目添加到仓库；


3、再通过git commit -m "注释内容"把项目提交到仓库；


4、在Github上设置好SSH密钥后，新建一个远程仓库，通过git remote add origin?https://github.com/anky07/sqlcode.git将本地仓库和远程仓库进行关联；


5、最后通过git push -u origin master把本地仓库的项目推送到远程仓库（也就是Github）上；
由于新建的远程仓库是空的，所以要加上-u这个参数，等远程仓库里面有了内容之后，下次再从本地库上传内容的时候只需下面这样就可以了：git push origin master

（若新建远程仓库的时候自动创建了README文件会报错，解决办法看上面）。



这里只是总结了Git上传项目的一些基本操作，要想更好地使用Git还需更进一步的学习。
写完代码后，我们一般这样

git add . //添加所有文件

git commit -m "本功能全部完成"

 

执行完commit后，想撤回commit，怎么办？

 

这样凉拌：

git reset --soft HEAD^

 

这样就成功的撤销了你的commit

注意，仅仅是撤回commit操作，您写的代码仍然保留。

 

 

说一下个人理解：
HEAD^的意思是上一个版本，也可以写成HEAD~1

如果你进行了2次commit，想都撤回，可以使用HEAD~2

 

至于这几个参数：
--mixed 
意思是：不删除工作空间改动代码，撤销commit，并且撤销git add . 操作
这个为默认参数,git reset --mixed HEAD^ 和 git reset HEAD^ 效果是一样的。
 

--soft  
不删除工作空间改动代码，撤销commit，不撤销git add . 
 
--hard
删除工作空间改动代码，撤销commit，撤销git add . 

注意完成这个操作后，就恢复到了上一次的commit状态。

 

 

顺便说一下，如果commit注释写错了，只是想改一下注释，只需要：
git commit --amend

此时会进入默认vim编辑器，修改注释完毕后保存就好了。
