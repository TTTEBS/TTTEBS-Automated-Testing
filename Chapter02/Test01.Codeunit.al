codeunit 50140 "Test01"
{
    Subtype = Test;

    [Test]
    procedure MessageFunction()
    begin
        Message('massage..');
    end;

    [Test]
    procedure ErrorFunction()
    begin
        Error('error..');
    end;
}

