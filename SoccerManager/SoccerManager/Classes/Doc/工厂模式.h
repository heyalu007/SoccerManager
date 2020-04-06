/**
 
 
 
 
1.分类
 
a）简单工厂模式
b）工厂方法模式
c）抽象工厂模式
 
 

2.简单工厂模式

简单工厂模式又称静态工厂方法模式。重命名上就可以看出这个模式一定很简单。它存在的目的很简单：定义一个用于创建对象的接口。
 先来看看它的组成：
 
 1)工厂类角色：这是本模式的核心，含有一定的商业逻辑和判断逻辑。在java中它往往由一个具体类实现。
 
 2)抽象产品角色：它一般是具体产品继承的父类或者实现的接口。在java中由接口或者抽象类来实现。
 
 3)具体产品角色：工厂类所创建的对象就是此角色的实例。在java中由一个具体类实现。


 举例：如NSNumber
 
 
 
 3.工厂方法模式
 
 
 1)抽象工厂角色： 这是工厂方法模式的核心，它与应用程序无关。是具体工厂角色必须实现的接口或者必须继承的父类。在java中它由抽象类或者接口来实现。
 
 2)具体工厂角色：它含有和具体业务逻辑有关的代码。由应用程序调用以创建对应的具体产品的对象。
 
 3)抽象产品角色：它是具体产品继承的父类或者是实现的接口。在java中一般有抽象类或者接口来实现。
 
 4)具体产品角色：具体工厂角色所创建的对象就是此角色的实例。在java中由具体的类来实现。






