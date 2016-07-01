defmodule CustomMatchersTest do
  use ExUnit.Case, async: true
  use ExMatchers

  defmodule Invoice do
    defstruct number: nil, payed: false, amount: nil
  end

  describe "a custom matcher without arguments" do
    defmodule InvoiceIsPayed do
      def to_match(invoice) do
        assert invoice.payed
      end
      def to_not_match(invoice) do
        refute invoice.payed
      end
    end
    defmatcher be_payed, with: InvoiceIsPayed

    test "is payed" do
      an_invoice = %Invoice{number: 100, payed: true, amount: 100}
      expect an_invoice, to: be_payed
    end

    test "is not payed" do
      an_invoice = %Invoice{number: 100, payed: false, amount: 100}
      expect an_invoice, to_not: be_payed
    end
  end

  describe "a custom matcher with arguments" do
    defmodule InvoiceReceivableAmount do
      def to_match(invoice, amount) do
        assert invoice.amount == amount
      end
      def to_not_match(invoice, amount) do
        refute invoice.amount == amount
      end
    end
    defmatcher has_received(amount), with: InvoiceReceivableAmount

    setup do
      %{actual: %Invoice{number: 100, payed: false, amount: 100}}
    end

    test "receives an amount", %{actual: an_invoice} do
      expect an_invoice, to: has_received(100)
    end
    test "do not receive and amount", %{actual: an_invoice} do
      expect an_invoice, to_not: has_received(200)
    end
  end

  describe "a custom matcher with argument and delta" do
    defmodule InvoiceReceivableAmountWithDelta do
      def to_match(invoice, amount, delta) do
        assert_in_delta invoice.amount, amount, delta
      end
      def to_not_match(invoice, amount, delta) do
        refute_in_delta invoice.amount, amount, delta
      end
    end

    defmatcher has_payed(amount), with: InvoiceReceivableAmountWithDelta

    setup do
      %{actual: %Invoice{number: 100, payed: false, amount: 100.0}}
    end

    test "receives an amount", %{actual: an_invoice} do
      expect an_invoice, to: has_payed(95.0), within: 10.0
    end

    test "do not receive and amount", %{actual: an_invoice} do
      expect an_invoice, to_not: has_payed(95.0), within: 4.0
    end
  end
end
