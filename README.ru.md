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
* `xpath` - элемент или документ  XP             поумолчанию
* `root` - Xобъект с опциямиn используются только cument и `strict`e
ault   - число передаваемое в нативный селектор        поумолчанию 0.
`strict` - указывает игнорировать ли исключения возникающие при выборке.
* `config` - object with options, only `type` using. `type` passed to native XPath selector, 0 by default
             конструктор объектов которые используются в данной библиотеке  унаследован от
`$X.Class` - constructor of objects used in this library, extends `Array`.
                    возвращает объект с тем же содержимым.
`$X.Class::clone` - return object with same content.
                                   применяет         к каждому элементу в объекте
`$X.Class::xpath(xpath, config)` - apply `xpath` to each element in current object.
                                 фильтрукт элементы по
`$X.Class::xpathFilter(xpath)` - filtering elements by `xpath`.
                       возвращает объект в котором каждый элемент включён только раз.
`$X.Class::unique()` - elements included in result only once.
                                           устанавливает обработчик            на событие         в каждом элементе
`$X.Class::addListener(event, callback)` - set `callback` to `event` for all elements.
                                              убирает обработчик            с события         для каждого элемента
`$X.Class::removeListener(event, callback)` - unset `callback` from `event` for all elements.
                                  ссылка на
`$X.Class::on(event, callback)` - link to `$X.Class.addListener`.
                                   ссылка на
`$X.Class::off(event, callback)` - link to `$X.Class.removeListener`.
                                   обработчик            выполнится только раз на каждом элементе
`$X.Class::one(event, callback)` - `callback` executed once for each element.
                                    обработчик            выполнится только раз
`$X.Class::once(event, callback)` - `callback` executed once.
                                     вызвать событие        с параметрами из
`$X.Class::dispatch(name, params)` - call event named `name` with parameters in `params`.
                                 ссылка на
`$X.Class::fire(name, params)` - link to `$X.Class.dispatch`.

`$X.Class::addClass(cls)` - 

`$X.Class::removeClass(cls)` -
                          устанавливает атрибуты из объекта `attrs`. Значения `null` и `undefined` убирают атрибуты.
`$X.Class::attr(attrs)` - set attributes from object `attrs`. `null` and `undefined` values removes attribute.
                            возвращает первый найденый атрибут с именем `attr` в элементах находящихся в объекте.
`$X.Class::getAttr(attr)` - return value of first attribute named `attr` of elements in object.
                          устанавливает стили из `styles`
`$X.Class::css(styles)` - set styles from `styles`.

`$X.Class::empty()` -

`$X.Class::remove()` -

`$X.Class::prepend()` -

`$X.Class::append()` -
                    
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

