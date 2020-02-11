codeunit 50141 "Test02"
{
    Subtype = Test;

    [Test]
    procedure ErrorFunction()
    begin
        Error('error..');
    end;

    [Test]
    procedure AssertErrorFunction()
    begin
        asserterror Error('assertError..');
    end;
}

