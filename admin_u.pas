unit admin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Data.Win.ADODB, Vcl.Buttons;

type
  TForm5 = class(TForm)
    pnl1: TPanel;
    btnLogOut: TButton;
    DBNavigator1: TDBNavigator;
    pnl2: TPanel;
    lblTop: TLabel;
    DBGrid2: TDBGrid;
    btnLogOut2: TButton;

    procedure btnLogOut2Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
uses Form_u;


procedure TForm5.btnLogOut2Click(Sender: TObject);
begin
  Form5.Close;
end;




end.
