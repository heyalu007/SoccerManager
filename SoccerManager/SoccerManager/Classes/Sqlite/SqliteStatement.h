/*

 1.IOS中的数据存储方式：
 a）Plist
 只能存NSArray或NSDictionary；
 b）Preference(偏好设置/NSUserDefaults)
 本质也是Plist，只能存储简单的对象类型。
 c）NSCoding(NSKeyedArchiver/NSKeyedUnarchiver)
 可以存任意对象。
 
 以上3种都不能存储大数据，因为它们的存储方式都是覆盖。比如往文件中添加数据，要先把旧数据读进来，再在程序中加上新数据，在写进文件。同时，在检索数据时，也只能把数据全部读出来，再在程序中查找。
 而数据库则可以直接增删查改。
 
 d）sqlite
 sqlite是一款轻型的嵌入式数据库，是用C语言实现的。也就是本文的重点。
 e）coredata
 coredata则基于sqlite封装了一层，是用OC实现重量型数据库。
 
 2.sqlite的基本概念：
 数据库存储方式就像excel，以表（table）为单位，一个数据库可以有多个表。
 列，称为字段（colum），也称为属性；
 行，称为记录（row）；
 
 3.sqlite的数据类型：
 integer：整数型
 real：浮点型
 text：文本字符串
 blob：二进制数据（比如文件）
 
 实际上sqlite是无类型的。编程时可以不指定类型，但为了规范，最好指定。
 
 
*/

/*
 
 1.SQL语句的特点
 a）不区分大小写；
 b）每个语句都必须以分号结尾；
 c）不可以关键字来命名表、字段等；
 
 2.基本语句
 a）建表：
 CREATE TABLE IF NOT EXISTS t_dog    (name text, age inter);
 b）删表：
 DROP TABLE IF EXISTS    t_dog;
 c）插入数据：
 INSERT INTO    t_shop (name, price, left_count) VALUES ("手机", 1999, 500);
 //没有必要全部都有字段都要照顾到，也可以只给两个字段插入数据。
 d）更新数据：
 UPDATE  t_shop  SET  price = 999,  left_count = 300;
 //上面是把字段的所有值都改了，因为没有条件；
 e）删除数据：
 DELETE FROM  t_shop
 //把表内部的全部数据都删除了，因为没有条件；
 
 3.条件语句：
 条件语句的常见格式：WHERE 字段 = 某个值；   //不能用两个=；
 UPDATE  t_shop  SET left_count = 0  WHERE  price = 999;
 DELETE  t_shop   WHERE  left_count = 0;
 DELETE  t_shop   WHERE   left_count < 300  AND  price > 2000;
 DELETE  t_shop   WHERE   left_count < 300  OR  price > 2000;
 
 4.查询语句
 SELECT  name，price  FROM  t_shop;
 SELECT  *  FROM  t_shop;//全部查询；
 SELECT  *  FROM  t_shop  WHERE  left_count > 800;
 //可以起别名，这里不再列举了。
 SELECT  count(*)  FROM  t_shop  WHERE  left_count > 800;
 //查询大于800的有多少条;
 
 5.升序和降序
 SELECT  *  FROM  t_shop  ORDER BY  price  DESC;//按照降序排，升序是ASC，但默认就是ASC;
 SELECT  *  FROM  t_shop  ORDER BY  price  DESC  left_count  ASC;//先按照价格排，再按照left_count排;
 
 
 6.简单约束
 
 6.1.limit
 SELECT * FROM t_shop LIMIT 5, 10; //跳过前面5条，取10条数据；
 SELECT * FROM t_shop ORDER BY price DESC LIMIT 0, 10; //先按照价格从高到低排序，再取10条价格最高的；
 
 LIMIT 5*(n - 1), 5;//limit常用来做分页处理，比如取第N页；
 
 
 6.2.NOT NULL //字段的值不为空;
 
 CREATE TABLE IF NOT EXISTS t_student (name text NOT NULL);
 
 6.3.UNIQUE //字段的值唯一;
 
 CREATE TABLE IF NOT EXITS t_shop (name text NOT NULL UNIQUE);//不能再有重名的;
 
 
 6.4.DEFAULT//默认的数值
 CREATE TABLE IF NOT EXISTS t_student (age integer DEFAULT 10);
 
 
7.主键约束
 
 //主键用来唯一的标记某一条记录，一般只用一个字段做主键；
 CREATE TABLE IF NOT EXISTS t_student (id interger, age integer DEFAULT 10);
 //id就是主键，声明了会自动增长；
 //主键是唯一的，隐藏了两个约束，NOT NULL 和 UNIPUE；

 
8.字段操作
 
 alter table 表名 add column 字段名 字段类型  //添加字段
 alter table 表名 drop column 字段名 //删除字段//这样写是不行的;
 alter table 表名 rename column 旧字段名 to 新字段名 //切换字段名
 
*/


/***********************************************************************************************************/

//删除height字段
NSString *createNewTable = @"create table temp as select name, age from t_test";
NSString *dropOldTable = @"drop table t_test";
NSString *renameTable = @"alter table temp rename to t_test";

//把height字段再加上
NSString *string = @"alter table t_test add column height real";

//这样加字段是不行的，主键约束只能在建表的时候设置
NSString *string = @"alter table t_test add column id interger primary key";

//删除数据，注意条件语句时，real类型的数据最好也加上单引号
NSString *string = @"delete from t_test where name = '王五'";



