program memorypatcher;
{$R *.RES}
uses
  Windows;

const buf:array[0..2] of byte=($83,$f8,$02); // ������ ���� - ���� ���, ������ ����� nop'�
filename='w3rus.exe'; // ��� �����
appname='Loader by Halt'; // �������� �����
var
i:cardinal;
sti:tstartupinfo;
lpPi:tprocessinformation;

begin
// ������� �������
if not CreateProcess(nil,filename,nil,nil,false,CREATE_NEW_CONSOLE or
NORMAL_PRIORITY_CLASS,nil,nil,StI,lpPI) then
begin
messageboxa(0,'� ��� '+filename+' ?',appname+'Loader by Halt',MB_ICONQUESTION);
halt;
end
else
while true do
if readprocessmemory(lppi.hProcess,pointer($4ad078),@buf[0],1,i) // ������ ���� ���� �� ������ 00441785
then
if buf[0]<>$0 then // ��������� �� ���������������, ���� �� 0 - �� �������������
begin
// ��������, ���� asprotect �������� ������, ����� ����� ������ 'Protection Error 15'
sleep(300);
//���������� �������
suspendthread(lppi.hThread);
//�������� ��� ������
writeprocessmemory(lppi.hProcess,pointer($4ad078),@buf[0],1,i);
writeprocessmemory(lppi.hProcess,pointer($4ad079),@buf[1],1,i);
writeprocessmemory(lppi.hProcess,pointer($4ad080),@buf[2],1,i);

//������� ������!
resumethread(lppi.hThread);
closehandle(lppi.hprocess);
// ���� �����������
halt;
end;
end.

