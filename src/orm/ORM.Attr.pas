unit ORM.Attr;

interface

uses
  System.Rtti, System.Variants, System.Classes;


type

  Table = class(TCustomAttribute)
  private
    fName: string;
  public
    constructor Create(const aName: string);
    property name: string read fName write fName;
  end;

  Column = class(TCustomAttribute)
  private
    fName: string;
  public
    Constructor Create(aName: string);
    property name: string read fName;
  end;

  PK = class(TCustomAttribute)
  end;

  FK = class(TCustomAttribute)
  end;

  NotNull = class(TCustomAttribute)
  end;

  Ignore = class(TCustomAttribute)
  end;

  AutoInc = class(TCustomAttribute)
  end;

  NumberOnly = class(TCustomAttribute)
  end;


implementation


{ Table }

constructor Table.Create(const aName: string);
begin
  fName :=aName;
end;

{ Column }

constructor Column.Create(aName: string);
begin
  fName :=aName;
end;

end.
