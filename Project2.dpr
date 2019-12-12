program Project2;

uses
  Vcl.Forms,
  Form_u in 'Form_u.pas' {Form6},
  admin_u in 'admin_u.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
