unit dbutils;

interface

uses
  System.SysUtils,
  Generics.Collections, System.Rtti, Data.DB,
  FireDAC.Comp.Client;


type

  Entity = class(TCustomAttribute)
  end;

  Automapping = class(TCustomAttribute)
  end;

  Model = class(TCustomAttribute)
  private
    fName: string;
  public
    constructor Create(const aName: string);
    property name: string read fName;
  end;

  Table = class(TCustomAttribute)
  private
    fName: string;
  public
    constructor Create(const aName: string);
    property name: string read fName write fName;
  end;



  ConnectionManager = object
  private
    fConnection: TFDCustomConnection;
  public
     function createInstance(): TFDCustomConnection;
     procedure destroyInstance();

  end;








implementation

{ ConnectionManager }

function ConnectionManager.createInstance: TFDCustomConnection;
begin
  if(not Assigned(fConnection))then
  begin
    fConnection :=TFDCustomConnection.Create(nil);
    fConnection.ConnectionString :='DriverID=SQLite;Database=abc21posto.db';
  end;
  Result :=fConnection;
end;

procedure ConnectionManager.destroyInstance;
begin
  if Assigned(fConnection)then
  begin
    FreeAndNil(fConnection);
  end;
end;


{ Model }

constructor Model.Create(const AName: string);
begin
  fName :=aName;
end;

{ Table }

constructor Table.Create(const aName: string);
begin

end;

end.
