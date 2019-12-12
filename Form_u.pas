unit Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Spin, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Vcl.Mask;

type
  TForm6 = class(TForm)
    edtUsername: TLabeledEdit;
    edtPassword: TLabeledEdit;
    btnLogin: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    btnSignUp: TButton;
    LabeledEdit5: TLabeledEdit;
    SpinEdit1: TSpinEdit;
    ADOConnection1: TADOConnection;
    Shape1: TShape;
    Shape2: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Label1: TLabel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    procedure btnSignUpClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);



   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;



implementation

{$R *.dfm}
uses admin_u;

function ValidEmail(email: string): boolean;

  // Returns True if the email address is valid

  const

    // Valid characters in an "atom"

    atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',

                                '\', '/', '"', '.', '[', ']', #127];

    // Valid characters in a "quoted-string"

    quoted_string_chars = [#0..#255] - ['"', #13, '\'];

    // Valid characters in a subdomain

    letters = ['A'..'Z', 'a'..'z'];

    letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];

    subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];

  type

    States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,

      STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,

      STATE_SUBDOMAIN, STATE_HYPHEN);

  var

    State: States;

    i, n, subdomains: integer;

    c: char;

  begin

    State := STATE_BEGIN;


    n := Length(email);

    i := 1;

    subdomains := 1;

    while (i <= n) do begin

      c := email[i];

      case State of

      STATE_BEGIN:

        if c in atom_chars then

          State := STATE_ATOM

        else if c = '"' then

          State := STATE_QTEXT

        else

          break;

      STATE_ATOM:

        if c = '@' then

          State := STATE_EXPECTING_SUBDOMAIN

        else if c = '.' then

          State := STATE_LOCAL_PERIOD

        else if not (c in atom_chars) then

          break;

      STATE_QTEXT:

        if c = '\' then

          State := STATE_QCHAR

        else if c = '"' then

          State := STATE_QUOTE

        else if not (c in quoted_string_chars) then

          break;

      STATE_QCHAR:

        State := STATE_QTEXT;

      STATE_QUOTE:

        if c = '@' then

          State := STATE_EXPECTING_SUBDOMAIN

        else if c = '.' then

          State := STATE_LOCAL_PERIOD

        else

          break;

      STATE_LOCAL_PERIOD:

        if c in atom_chars then

          State := STATE_ATOM

        else if c = '"' then

          State := STATE_QTEXT

        else

          break;

      STATE_EXPECTING_SUBDOMAIN:

        if c in letters then

          State := STATE_SUBDOMAIN

        else

          break;

      STATE_SUBDOMAIN:

        if c = '.' then begin

          inc(subdomains);

          State := STATE_EXPECTING_SUBDOMAIN

        end else if c = '-' then

          State := STATE_HYPHEN

        else if not (c in letters_digits) then

          break;

      STATE_HYPHEN:

        if c in letters_digits then

          State := STATE_SUBDOMAIN

        else if c <> '-' then

          break;

      end;

      inc(i);

    end;

    if i <= n then

      Result := False

    else

      Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);

  end;


procedure TForm6.btnLoginClick(Sender: TObject);
begin
   ADOQuery1.SQL.Clear;
   ADOQuery1.SQL.Add('select * from Profiles where Username=''' +edtUsername.Text+ ''' and password=''' +edtPassword.Text+ ''' ' );
   ADOQuery1.Open;


   if(edtUsername.Text='admin')and(edtPassword.Text='admin')then
   begin
      form5.show;
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('select* from Profiles');
      ADOQuery1.Open;
      form5.lblTop.Caption :='Welcome admin';
      form5.lblTop.Font.Size :=16;
      form5.DBNavigator1.show;
      form5.DBGrid2.ReadOnly:=False;

   end else if not(ADOQuery1.eof)then
   begin

       form5.show;
       ADOQuery1.SQL.Clear;
       ADOQuery1.SQL.Add('select* from Profiles');
       ADOQuery1.Open;
       form5.lblTop.Caption :='Welcome';
       form5.lblTop.Font.Size :=16;
       form5.DBNavigator1.Hide;
       form5.DBGrid2.ReadOnly:=TRUE;

   end else if(edtUsername.Text='')and(edtPassword.Text='') then
   begin
      ShowMessage('Please enter your account:');
      edtUsername.SetFocus;//if user didn't enter anything

   end else if (edtUsername.Text='')then
   begin
      ShowMessage('Please enter Username');
      edtUsername.SetFocus;//username

   end else if ADOQuery1.Locate('Username',edtUsername.Text,[])=False then
   begin
        ShowMessage('Wrong username');
        edtUsername.Clear;
        edtUsername.SetFocus;
        ADOQuery1.SQL.Clear;//wrong username

   end else if (edtPassword.Text='')then
   begin
      ShowMessage('Please enter Password');
      edtPassword.SetFocus;//Password

   end else if ADOQuery1.Locate('Password',edtPassword.Text,[])=False then
   begin
        ShowMessage('Wrong password');
        edtPassword.Clear;
        edtPassword.SetFocus;
        ADOQuery1.SQL.Clear;//wrong password
   end;

end;



procedure TForm6.btnSignUpClick(Sender: TObject);
                                             //checkout form and post
begin

  if(LabeledEdit1.Text='')and(LabeledEdit2.Text='')and(LabeledEdit3.Text='')and(LabeledEdit4.Text='') then
  begin
    ShowMessage('Please Fill Entire Form...');
    LabeledEdit1.SetFocus;//all field missing

  end else if(LabeledEdit1.Text='') and (LabeledEdit2.Text='') and (LabeledEdit3.Text='') then
  begin
    ShowMessage('You must need to enter name and password...');
    LabeledEdit1.SetFocus;//name and password

  end else if(LabeledEdit2.Text)<>(LabeledEdit3.Text)then
  begin
    ShowMessage('Password does not match!!!');
    LabeledEdit3.Clear;
    LabeledEdit3.SetFocus;//two password  match or not

  end else if(LabeledEdit1.Text='')and(LabeledEdit4.Text='')then
   begin
    ShowMessage('You forgot to fill name and email...');
    LabeledEdit1.SetFocus;//name and email

  end else if(LabeledEdit2.Text='')and(LabeledEdit4.Text='')then
  begin
    ShowMessage('Your password and email fields empty!!!!');
    LabeledEdit2.SetFocus;//password and email

  end else if(LabeledEdit1.Text='')then
  begin
    ShowMessage('Please enter username...');
    LabeledEdit1.SetFocus; //name

  end else if  ADOQuery1.Locate('Username',LabeledEdit1.Text,[])=true then
  begin
    ShowMessage('Username Already exists!!');
    LabeledEdit1.Clear;
    LabeledEdit1.SetFocus;//same name

  end else if(LabeledEdit2.Text='')then
  begin
    ShowMessage('You must set your password to login');
    LabeledEdit2.SetFocus; //password

  end else if(LabeledEdit4.Text='')then
  begin
    ShowMessage('Please fill your email.');
    LabeledEdit4.SetFocus; //email

  end else if not ValidEmail(LabeledEdit4.Text) then
  begin
    ShowMessage('Invalid Email');
    LabeledEdit4.Clear;
    LabeledEdit4.SetFocus; //email format

  end else if   ADOQuery1.Locate('Email',LabeledEdit4.Text,[])=true then
  begin
    ShowMessage('Email Already exists!!!Plz use another');
    LabeledEdit4.Clear;
    LabeledEdit4.SetFocus;//same email

  end else
  begin
  ADOQuery1.Active := TRUE;
  ADOQuery1.Append;
  ADOQuery1['Username'] := LabeledEdit1.Text;
  ADOQuery1['Password'] := LabeledEdit2.Text;
  ADOQuery1['Confirmed Password'] := LabeledEdit3.Text;
  ADOQuery1['Email'] := LabeledEdit4.Text;
  ADOQuery1['Age']   := SpinEdit1.Value;

  ADOQuery1.Post;




  LabeledEdit1.Text := '';
  LabeledEdit2.Text :='';
  LabeledEdit3.Text :='';
  LabeledEdit4.Text :='';
  SpinEdit1.Value :=0  ;

  ShowMessage('You have successfully registered.');
  LabeledEdit1.SetFocus;
  end;
  //it's work

end;




end.
