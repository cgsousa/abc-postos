unit ORM.SQLAttr;

interface

uses
    ORM.Intf;

type
  TBaseORMSQLAttr<T: class> = class(TInterfacedObject, IBaseORMSQLAttr<T>)
  private
    [weak]
    fParent: IBaseORM<T>;
    fFields: String;
    fWhere: String;
    fOrderBy: String;
    fGroupBy: String;
    fJoin: String;
  public
    constructor Create(parent: IBaseORM<T>);
    destructor Destroy; override;

    function fields(aSQL: String): IBaseORMSQLAttr<T>; overload;
    function where(aSQL: String): IBaseORMSQLAttr<T>; overload;
    function orderBy(aSQL: String): IBaseORMSQLAttr<T>; overload;
    function groupBy(aSQL: String): IBaseORMSQLAttr<T>; overload;
    function join(aSQL: String): IBaseORMSQLAttr<T>; overload;

    function clear: IBaseORMSQLAttr<T>;

    function fields: String; overload;
    function where: String; overload;
    function orderBy: String; overload;
    function groupBy: String; overload;
    function join: String; overload;
    function &end: IBaseORM<T>;

    //class function New(Parent: iSimpleDAO<T>): iSimpleDAOSQLAttribute<T>;
  end;


implementation

end.
