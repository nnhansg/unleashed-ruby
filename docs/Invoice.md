# Invoices

## Get all invoices

```ruby
# List all invoices
# /Invoices - also returns the first 200 invoices because page number 1 is the default.
#
# @param options [Hash] Optional options.
# @option Page: Page index. Default: 1
# @option PageSize: Specifies the page size for pagination. Default page size is 200 invoices.
# @option CustomerCode: Returns invoices that matches the specific customer code.
# @option StartDate: Returns invoices created after a specified date, must be UTC format.
# @option EndDate: Returns invoices created before a specified date, must be UTC format.
# @option ModifiedSince: Returns invoices created or edited after a specified date, must be UTC format.
# @option OrderNumber: Returns the invoices associated with the Sales Order Number.
# @option InvoiceNumber: Returns a single invoice with the specified invoice number. If set, it overrides all other filters.
# @option InvoiceStatus: Returns invoices with the specified status. Multiple selection can be specified as comma separated.For example: `invoiceStatus=Completed,Parked`. If no invoiceStatus filter is specified, then we exclude “Deleted” by default.
# @option SerialBatch: False by default. If set to true then the attributes SerialNumbers and BatchNumbers are displayed.
#
# @return [Array<Unleashed::Invoice>] List all invoices.
client.invoices.all
```

## Get an invoice

```ruby
client.invoices.find('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX')
```

## Get the first invoice

```ruby
client.invoices.first
```

## Get the last invoice

```ruby
client.invoices.last
```
