require File.expand_path(File.dirname(__FILE__) + '/../../test_helper')

describe ::Inch::CodeObject::NodocHelper do
  before do
    Dir.chdir fixture_path(:simple)
    @source_parser = Inch::SourceParser.run(["lib/**/*.rb"])
  end

  it "should return true for explicitly tagged objects" do
    [
      "Foo::Qux",
      "Foo::Qux#method_with_implicit_nodoc",
      "Foo::Qux::Quux#method_with_private_tag",
      "Foo::Qux::Quux#method_with_explicit_nodoc",
      "Foo::Qux::Quux::PRIVATE_VALUE",
      "Foo::HiddenClass",
      "Foo::HiddenClass::EvenMoreHiddenClass",
      "Foo::HiddenClass::EvenMoreHiddenClass#method_with_implicit_nodoc",
    ].each do |query|
      m = @source_parser.find_object(query)
      assert m.nodoc?, "nodoc? should return true for #{query}"
    end
  end

  it "should return false for other objects" do
    [
      "Foo::Qux::Quux#method_without_nodoc",
      "Foo::Qux::Quux::PUBLIC_VALUE",
      "Foo::Qux::DOCCED_VALUE",
      "Foo::HiddenClass::EvenMoreHiddenClass::SuddenlyVisibleClass",
      "Foo::HiddenClass::EvenMoreHiddenClass::SuddenlyVisibleClass#method_with_implicit_doc",
    ].each do |query|
      m = @source_parser.find_object(query)
      refute m.nodoc?, "nodoc? should return false for #{query}"
    end
  end

end
