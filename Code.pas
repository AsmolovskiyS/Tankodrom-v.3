unit Code;

interface
Function Code_Code(Str:String):String;
Function Code_DeCode(Str:String):String;
implementation

Function Code_Code(Str:String):String;
var Dl,x,i:Integer; c:Char; s:String;
Begin
dl:=Length(str);
For i:=1 to Dl do
Begin
c:=Str[i];
x:=Ord(c)+300+i;
s:=S+Chr(x);
end;
Result:=s;
end;

Function Code_DeCode(Str:String):String;
var Dl,x,i:Integer; c:Char; s:String;
Begin
dl:=Length(str);
For i:=1 to Dl do
Begin
c:=Str[i];
x:=Ord(c)-300-i;
s:=S+Chr(x);
end;
Result:=s;
end;

end.
 