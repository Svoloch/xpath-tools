xpath-tools
===========
Набор инструментов упрощающий работу с DOM посредством XPath

Предварительная подготовка
--------------------------

Перед использованием выполнить комманду:
```
cat core.coffee utils.coffee events.coffee | coffee -c -s -b > xpath.js
```
После этого можно подключать `xpath.js` к HTML, SVG и другим подобным файлам используя тег `<script/>`.

Способы использования
---------------------

`$X` - главная функция.

`$X("//input[@type='number']")`
выбрать все поля ввода чисел.

`$X("//table").xpath("count(tr|tbody/tr)")`
посчитать количество строк во всех таблицах в документе.

`$C("cls").xpathFilter("img")`
элементы с классом `cls` содержащие изображение.


`core.coffee`
-------------

Это основная часть кода.

`$X(xpath, root, config)` применить `xpath` как XPath к элементу `root` с опцими переанными через `config`;
возвращает объект унаследованый от массива с результатом выборки
result.     строка с
* `xpath` - элемент или документ XPath объект поумолчанию
* `root` - XML елемент с которого начинается поиск, поумолчанию `document`
* `config` - объект с опцими, сейчас корректно работает только `type`

`$X.Class` - конструктор объектов которые используются в данной библиотеке  унаследован от `Array`.
                    
`$X.Class::clone` - возвращает объект с тем же содержимым.
                                   
`$X.Class::xpath(xpath, config)` - применяет `xpath` к каждому элементу в объекте.
                                 
`$X.Class::xpathFilter(xpath)` - фильтрует элементы по `xpath`.
                       
`$X.Class::unique()` - возвращает объект в котором каждый элемент включён только раз.
                                           
`$X.Class::addListener(event, callback)` - устанавливает обработчик `callback` на событие `event` в каждом элементе
                                              
`$X.Class::removeListener(event, callback)` - убирает обработчик `callback` с события `event` для каждого элемента
                                  
`$X.Class::on(event, callback)` - ссылка на `$X.Class.addListener`.

`$X.Class::off(event, callback)` - ссылка на `$X.Class.removeListener`.
                                   
`$X.Class::one(event, callback)` - обработчик `callback` выполнится только раз на каждом элементе.
                                    
`$X.Class::once(event, callback)` - обработчик `callback` выполнится только раз.
                                     
`$X.Class::dispatch(name, params)` - вызвать событие `name` с параметрами из `params`.
                                 
`$X.Class::fire(name, params)` - ссылка на `$X.Class.dispatch`.

`$X.Class::addClass(cls)` - 

`$X.Class::removeClass(cls)` -
                          
`$X.Class::attr(attrs)` - устанавливает атрибуты из объекта `attrs`. Значения `null` и `undefined` убирают атрибуты.

`$X.Class::getAttr(attr)` - возвращает первый найденый атрибут с именем `attr` в элементах находящихся в объекте.

`$X.Class::css(styles)` - устанавливает стили из `styles`.

`$X.Class::empty()` -

`$X.Class::remove()` -

`$X.Class::prepend()` -

`$X.Class::append()` -

`$X.Class::replace()` -

`$X.Class::replaceContent()` -

`$X.Class::getFirstNode()` - первая нода в контейнере, не в DOM.

`$X.Class::val()` - возвращает значение из первого попавшегося элемента ввода.
                         
`$X.Class::val(value)` - устанавливает значение `value` на первый попавшийся элемент ввода.
               
`$X.clone()` - клонирует `$X`, полезно когда библиотека используется с разными настройками в одном проекте.
                
`$X.defaults` - объект с настройками библиотеки.

`$X.defaults.ns` - объект с префиксами пространств имён используемых в XPath выражениях.


`off.coffee`
------------

`$X.Class::addListener` и `$X.Class::removeListener` заменяются аналогами позволяющими отменять все обработчики одного события.

`$X.Class::removeListener(event)` - убирает все обработчики с события `event` на каждом элементе.

`events.coffee`
---------------

Позволяет устанавливать обработчики на события вызывая их в качестве метода.

`iepatch.coffee`
----------------

Попытка поддержки Internet Exploer версии ниже 7.

`utils.coffee`
--------------
Набор полезных функций для манипуляции DOM.

`$R(callback)` - выполняет `callback` после загрузки документа.

`$A(arr...)` - возвращает объект типа `$X.Class` с элементами из `arr`.
Массивы и подмассивы разворачиваются в один массив.

`$ID(id)` - выбрать элемент по индексу.

`$C(cls)` - выбрать элементы по классу.

`$N(name)` - выбрать элементы по имени.

`$html(tag)` - создаёт HTML элемент.

`$svg(tag)` - создаёт SVG элемент.

`$X.Class::concat`, `$X.Class::slice`, `$X.Class::splice`, `$X.Class::map`, `$X.Class::filter` - возвращают значение типа `$X.Class`.

`$L` - вывод на консоль.

