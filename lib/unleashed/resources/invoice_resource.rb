module Unleashed
  # Resource for the Invoices API
  # The Invoices resource allows sales invoices to be listed and viewed.
  # An individual sales invoice details can be viewed by appending its identifier
  # (a GUID formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX) to the URI.
  #
  # @see https://apidocs.unleashedsoftware.com/Invoices
  class InvoiceResource < BaseResource
    def model
      Unleashed::Invoice
    end

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
    # { Pagination: { NumberOfItems: 2, PageSize: 200, PageNumber: 1, NumberOfPages: 1 },
    # Items: [ { InvoiceNumber: "SI-137", OrderNumber: "SO-137", QuoteNumber: nil,
    #   InvoiceDate: "/Date(1565058456626)/", DueDate: "/Date(1568937600000)/",
    #   InvoiceStatus: "Completed", Customer: { CustomerCode: "WADE",
    #     CustomerName: "Wade's Apparel & Accessories", CurrencyId: 110,
    #     Guid: "b9f21e05-07fe-4d9d-b460-a09db4c3caa9", LastModifiedOn: "/Date(1559778437146)/" },
    #     Comments: nil, PostalAddress: nil, DeliveryAddress: { AddressType: nil,
    #       AddressName: nil, StreetAddress: nil, StreetAddress2: nil, Suburb: nil, City: nil,
    #       Region: nil, Country: nil, PostalCode: nil, IsDefault: false },
    #       DeliveryInstruction: "Handle with care.", SubTotal: 25.0, TaxTotal: 5.0, Total: 30.0,
    #       BCSubTotal: 25.27, BCTaxTotal: 5.05, BCTotal: 30.32, CreatedBy: "james@JamesInc.com",
    #       PaymentTerm: "20th Month following", InvoiceLines: [ { LineNumber: 1, LineType: nil,
    #         Product: { Guid: "23280680-a2bd-4873-a390-501e0f3399d1", ProductCode: "NAIL-M",
    #           ProductDescription: "Medium Nails" }, OrderQuantity: 1.0, InvoiceQuantity: 1.0,
    #           UnitPrice: 25.0, DiscountRate: 0.0, LineTotal: 25.0, Comments: "", TaxRate: 0.2,
    #           LineTax: 5.0, BCUnitPrice: 25.2729, SerialNumbers: nil, BatchNumbers: nil,
    #           Guid: "866e295f-76fb-49e7-9407-b2ed4e0a5d0d", LastModifiedOn: "/Date(1565058457156)/" } ],
    #           Guid: "10a1571d-8c5a-4e5e-bbba-bc3215a27e17", LastModifiedOn: "/Date(1565058457161)/" },
    #           { InvoiceNumber: "SI-136", OrderNumber: "SO-136", QuoteNumber: nil,
    #             InvoiceDate: "/Date(1565058268231)/", DueDate: "/Date(1568937600000)/",
    #             InvoiceStatus: "Completed", Customer: { CustomerCode: "WADE",
    #               CustomerName: "Wade's Apparel & Accessories", CurrencyId: 110,
    #               Guid: "b9f21e05-07fe-4d9d-b460-a09db4c3caa9", LastModifiedOn: "/Date(1559778437146)/" },
    #               Comments: nil, PostalAddress: nil, DeliveryAddress: { AddressType: nil,
    #                 AddressName: nil, StreetAddress: nil, StreetAddress2: nil, Suburb: nil, City: nil,
    #                 Region: nil, Country: nil, PostalCode: nil, IsDefault: false },
    #                 DeliveryInstruction: nil, SubTotal: 25.0, TaxTotal: 5.0, Total: 30.0,
    #                 BCSubTotal: 25.27, BCTaxTotal: 5.05, BCTotal: 30.32, CreatedBy: "james@JamesInc.com",
    #                 PaymentTerm: "20th Month following", InvoiceLines: [ { LineNumber: 1, LineType: nil,
    #                   Product: { Guid: "23280680-a2bd-4873-a390-501e0f3399d1", ProductCode: "NAIL-M",
    #                     ProductDescription: "Medium Nails" }, OrderQuantity: 1.0, InvoiceQuantity: 1.0,
    #                     UnitPrice: 25.0, DiscountRate: 0.0, LineTotal: 25.0, Comments: "", TaxRate: 0.2,
    #                     LineTax: 5.0, BCUnitPrice: 25.2729, SerialNumbers: nil, BatchNumbers: nil,
    #                     Guid: "2b994962-e446-4b18-b8c7-5f445adde8cc", LastModifiedOn: "/Date(1565058268757)/" } ],
    #                     Guid: "5cc41e1e-468f-4c01-beb9-a077fc06df46", LastModifiedOn: "/Date(1565058268764)/" } ] }
    def all(options = { Page: 1, PageSize: 200 })
      endpoint = 'Invoices'
      params = options.dup

      # Handle Page option
      endpoint << "/#{params[:Page]}" if params[:Page].present?
      response = JSON.parse(@client.get(endpoint, params).body)
      invoices = response.key?('Items') ? response['Items'] : []
      invoices.map { |attributes| Unleashed::Invoice.new(@client, attributes) }
    end

    # Get a single invoice
    # /Invoices/E6E8163F-6911-40e9-B740-90E5A0A3A996 - returns details of a particular invoice.
    #
    # @param id [String] invoice ID.
    #
    # @return [Unleashed::Invoice]
    def find(id)
      response = JSON.parse(@client.get("Invoices/#{id}").body)
      Unleashed::Invoice.new(@client, response)
    end

    # Get a first invoice in all
    #
    # @return [Unleashed::Invoice]
    def first
      all.first
    end

    # Get a last invoice in all
    #
    # @return [Unleashed::Invoice]
    def last
      all.last
    end
  end
end
