# ChangeLog

## 0.0.3

* Enhancements
  * Handle Thrift exceptions by returning {:exception, the_exception} instead
    of generating a cryptic "bad return value" exit from GenServer.call

## 0.0.2

* Enhancements
  * Now using structs instead of records to represent Thrift structs

## 0.0.1

* Initial release
