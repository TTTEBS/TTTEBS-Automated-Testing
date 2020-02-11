codeunit 50142 "Test03"
{
    Subtype = Test;

    [Test]
    [HandlerFunctions('MessageHandlerFunction')]
    procedure MessageFunction()
    begin
        Message('message..');
    end;

    [MessageHandler]
    procedure MessageHandlerFunction(Message: Text[1024])
    begin

    end;
}

