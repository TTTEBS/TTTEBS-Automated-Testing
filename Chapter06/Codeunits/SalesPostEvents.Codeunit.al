codeunit 50147 "SalesPostEvents"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDocEvent(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do
            TestField("Lookup Value Code");
    end;
}