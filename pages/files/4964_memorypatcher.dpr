program memorypatcher;
{$R *.RES}
uses
  Windows;

const buf:array[0..2] of byte=($83,$f8,$02); // Первый байт - хоть что, второй опкод nop'а
filename='w3rus.exe'; // Имя файла
appname='Loader by Halt'; // Название проги
var
i:cardinal;
sti:tstartupinfo;
lpPi:tprocessinformation;

begin
// Создаем процесс
if not CreateProcess(nil,filename,nil,nil,false,CREATE_NEW_CONSOLE or
NORMAL_PRIORITY_CLASS,nil,nil,StI,lpPI) then
begin
messageboxa(0,'А где '+filename+' ?',appname+'Loader by Halt',MB_ICONQUESTION);
halt;
end
else
while true do
if readprocessmemory(lppi.hProcess,pointer($4ad078),@buf[0],1,i) // Читаем один байт по адресу 00441785
then
if buf[0]<>$0 then // Проверяем на распакованность, если не 0 - то распаковалась
begin
// Подождем, пока asprotect проверит память, иначе будет писать 'Protection Error 15'
sleep(300);
//остановили процесс
suspendthread(lppi.hThread);
//записали что хотели
writeprocessmemory(lppi.hProcess,pointer($4ad078),@buf[0],1,i);
writeprocessmemory(lppi.hProcess,pointer($4ad079),@buf[1],1,i);
writeprocessmemory(lppi.hProcess,pointer($4ad080),@buf[2],1,i);

//поехали дальше!
resumethread(lppi.hThread);
closehandle(lppi.hprocess);
// Сами закрываемся
halt;
end;
end.

