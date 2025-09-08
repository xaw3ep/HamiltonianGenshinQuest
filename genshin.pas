const fi='hamilton.inp';
      fo='hamilton.out';
var f:text;
    a:array[1..100, 1..100] of boolean;
    free:array[1..100] of boolean;
    x:array[1..100] of integer;
    d:array[0..4,0..5] of byte;
    n,i,j,m,mark:integer;
procedure putroad(i,j:integer);
var t1,t2:integer;
begin
 t1:=(i-1)*4 + j;
 if ((d[i+1,j]<>0) and (
  (d[i,j] +1= d[i+1,j]) or
  (d[i,j] = 3) and (d[i+1,j] =1))
  ) then
   begin
    inc(m);
    a[t1,i*4+j]:=true;
   end;
 if ((d[i-1,j]<>0)
  and ((d[i,j]+1= d[i-1,j]) or (d[i,j] = 3) and (d[i-1,j] =1))) then
   begin
    inc(m);
    a[t1,(i-2)*4+j]:=true;
   end;
 if ((d[i,j+1]<>0)
  and ((d[i,j]+1= d[i,j+1]) or (d[i,j] = 3) and (d[i,j+1] =1))) then
   begin
    inc(m);
    a[t1,t1+1]:=true;
   end;

 if ((d[i,j-1]<>0)
  and ((d[i,j]+1= d[i,j-1]) or (d[i,j] = 3) and (d[i,j-1] =1))) then
   begin
    inc(m);
    a[t1,t1-1]:=true;
   end;

end;
procedure print;
var k:integer;
begin
 for k:=1 to n do
  write(f, x[k],' ');
 writeln(f);
end;
procedure try(i:integer);
var j:integer;
begin
 for j:=1 to n do
  if Free[j] and a[x[i-1],j] then
   begin
    x[i]:=j;
    if i < n then
     begin
      inc(mark);
      free[j]:=false;
      try(i+1);
      dec(mark);
      free[j]:=true;
     end else if mark = 11 then print;
   end;
end;
begin
 m:=0;
 fillchar(d,sizeof(d),0);
 assign(f,fi);
 reset(f);
 n:=12;
 for i:=1 to 3 do
  for j:=1 to 4 do
   read(f,d[i,j]);

 for i:=1 to 3 do
  for j:=1 to 4 do
   putroad(i,j);
 close(f);
 assign(f,fo);
 rewrite(f);

 for i:=1 to 12 do
  begin
   mark:=1;
   fillchar(free,sizeof(free),true);
   x[1]:=i; free[i]:=false;
   try(2);
  end;
 close(f);
end.
