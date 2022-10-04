# typed: strict
# frozen_string_literal: true

require "spec_helper"

module Tapioca
  module Dsl
    module Compilers
      class DryStructSpec < ::DslSpec
        describe "initialize" do
          it "gathers no constants if there are no ::Dry::Struct subclasses" do
            assert_empty(gathered_constants)
          end

          it "gathers only ::Dry::Struct subclasses" do
            add_ruby_file("structs.rb", <<~RUBY)
              class Spam < ::Dry::Struct
              end

              class Ham
              end
            RUBY

            assert_equal(["Spam"], gathered_constants)
          end
        end

        describe "decorate" do
          it "generates an empty RBI file if there is no attributes" do
            add_ruby_file("structs.rb", <<~RUBY)
              class Spam < ::Dry::Struct
              end
            RUBY

            expected = <<~RBI
              # typed: strong

              class Spam; end
            RBI

            assert_equal(expected, rbi_for(:Spam))
          end

          it "generates correct RBI file for builtin types" do
            add_ruby_file("example_builtin.rb", <<~RUBY)
              class ExampleBuiltin < ::Dry::Struct
                Dry::Types.load_extensions(:maybe)
                Dry::Types.load_extensions(:monads)

                module Types
                  include ::Dry.Types()
                end

                attribute :builtin01, Types::Nominal::Any
                attribute :builtin02, Types::Nominal::Nil
                attribute :builtin03, Types::Nominal::Symbol
                attribute :builtin04, Types::Nominal::Class
                attribute :builtin05, Types::Nominal::True
                attribute :builtin06, Types::Nominal::False
                attribute :builtin07, Types::Nominal::Bool
                attribute :builtin08, Types::Nominal::Integer
                attribute :builtin09, Types::Nominal::Float
                attribute :builtin10, Types::Nominal::Decimal
                attribute :builtin11, Types::Nominal::String
                attribute :builtin12, Types::Nominal::Date
                attribute :builtin13, Types::Nominal::DateTime
                attribute :builtin14, Types::Nominal::Time
                attribute :builtin15, Types::Nominal::Array
                attribute :builtin16, Types::Nominal::Hash

                attribute :builtin17, Types::Strict::Nil
                attribute :builtin18, Types::Strict::Symbol
                attribute :builtin19, Types::Strict::Class
                attribute :builtin20, Types::Strict::True
                attribute :builtin21, Types::Strict::False
                attribute :builtin22, Types::Strict::Bool
                attribute :builtin23, Types::Strict::Integer
                attribute :builtin24, Types::Strict::Float
                attribute :builtin25, Types::Strict::Decimal
                attribute :builtin26, Types::Strict::String
                attribute :builtin27, Types::Strict::Date
                attribute :builtin28, Types::Strict::DateTime
                attribute :builtin29, Types::Strict::Time
                attribute :builtin30, Types::Strict::Array
                attribute :builtin31, Types::Strict::Hash

                attribute :builtin32, Types::Coercible::String
                attribute :builtin33, Types::Coercible::Symbol
                attribute :builtin34, Types::Coercible::Integer
                attribute :builtin35, Types::Coercible::Float
                attribute :builtin36, Types::Coercible::Decimal
                attribute :builtin37, Types::Coercible::Array
                attribute :builtin38, Types::Coercible::Hash

                attribute :builtin39, Types::Params::Nil
                attribute :builtin40, Types::Params::Date
                attribute :builtin41, Types::Params::DateTime
                attribute :builtin42, Types::Params::Time
                attribute :builtin43, Types::Params::True
                attribute :builtin44, Types::Params::False
                attribute :builtin45, Types::Params::Bool
                attribute :builtin46, Types::Params::Integer
                attribute :builtin47, Types::Params::Float
                attribute :builtin48, Types::Params::Decimal
                attribute :builtin49, Types::Params::Array
                attribute :builtin50, Types::Params::Hash

                attribute :builtin51, Types::JSON::Nil
                attribute :builtin52, Types::JSON::Symbol
                attribute :builtin53, Types::JSON::Date
                attribute :builtin54, Types::JSON::DateTime
                attribute :builtin55, Types::JSON::Time
                attribute :builtin56, Types::JSON::Decimal
                attribute :builtin57, Types::JSON::Array
                attribute :builtin58, Types::JSON::Hash

                attribute :builtin59, Types::Maybe::Strict::Class
                attribute :builtin60, Types::Maybe::Strict::String
                attribute :builtin61, Types::Maybe::Strict::Symbol
                attribute :builtin62, Types::Maybe::Strict::True
                attribute :builtin63, Types::Maybe::Strict::False
                attribute :builtin64, Types::Maybe::Strict::Integer
                attribute :builtin65, Types::Maybe::Strict::Float
                attribute :builtin66, Types::Maybe::Strict::Decimal
                attribute :builtin67, Types::Maybe::Strict::Date
                attribute :builtin68, Types::Maybe::Strict::DateTime
                attribute :builtin69, Types::Maybe::Strict::Time
                attribute :builtin70, Types::Maybe::Strict::Array
                attribute :builtin71, Types::Maybe::Strict::Hash

                attribute :builtin72, Types::Maybe::Coercible::String
                attribute :builtin73, Types::Maybe::Coercible::Integer
                attribute :builtin74, Types::Maybe::Coercible::Float
                attribute :builtin75, Types::Maybe::Coercible::Decimal
                attribute :builtin76, Types::Maybe::Coercible::Array
                attribute :builtin77, Types::Maybe::Coercible::Hash
              end
            RUBY

            expected = <<~RBI
              # typed: strong

              class ExampleBuiltin
                sig { returns(::T.untyped) }
                def builtin01; end

                sig { returns(::NilClass) }
                def builtin02; end

                sig { returns(::Symbol) }
                def builtin03; end

                sig { returns(::Class) }
                def builtin04; end

                sig { returns(::T::Boolean) }
                def builtin05; end

                sig { returns(::T::Boolean) }
                def builtin06; end

                sig { returns(::T::Boolean) }
                def builtin07; end

                sig { returns(::Integer) }
                def builtin08; end

                sig { returns(::Float) }
                def builtin09; end

                sig { returns(::BigDecimal) }
                def builtin10; end

                sig { returns(::String) }
                def builtin11; end

                sig { returns(::Date) }
                def builtin12; end

                sig { returns(::DateTime) }
                def builtin13; end

                sig { returns(::ActiveSupport::TimeWithZone) }
                def builtin14; end

                sig { returns(::Array) }
                def builtin15; end

                sig { returns(::T::Hash[::T.untyped, ::T.untyped]) }
                def builtin16; end

                sig { returns(::NilClass) }
                def builtin17; end

                sig { returns(::Symbol) }
                def builtin18; end

                sig { returns(::Class) }
                def builtin19; end

                sig { returns(::T::Boolean) }
                def builtin20; end

                sig { returns(::T::Boolean) }
                def builtin21; end

                sig { returns(::T::Boolean) }
                def builtin22; end

                sig { returns(::Integer) }
                def builtin23; end

                sig { returns(::Float) }
                def builtin24; end

                sig { returns(::BigDecimal) }
                def builtin25; end

                sig { returns(::String) }
                def builtin26; end

                sig { returns(::Date) }
                def builtin27; end

                sig { returns(::DateTime) }
                def builtin28; end

                sig { returns(::ActiveSupport::TimeWithZone) }
                def builtin29; end

                sig { returns(::Array) }
                def builtin30; end

                sig { returns(::T::Hash[::T.untyped, ::T.untyped]) }
                def builtin31; end

                sig { returns(::String) }
                def builtin32; end

                sig { returns(::Symbol) }
                def builtin33; end

                sig { returns(::Integer) }
                def builtin34; end

                sig { returns(::Float) }
                def builtin35; end

                sig { returns(::BigDecimal) }
                def builtin36; end

                sig { returns(::Array) }
                def builtin37; end

                sig { returns(::T::Hash[::T.untyped, ::T.untyped]) }
                def builtin38; end

                sig { returns(::NilClass) }
                def builtin39; end

                sig { returns(::Date) }
                def builtin40; end

                sig { returns(::DateTime) }
                def builtin41; end

                sig { returns(::ActiveSupport::TimeWithZone) }
                def builtin42; end

                sig { returns(::T::Boolean) }
                def builtin43; end

                sig { returns(::T::Boolean) }
                def builtin44; end

                sig { returns(::T::Boolean) }
                def builtin45; end

                sig { returns(::Integer) }
                def builtin46; end

                sig { returns(::Float) }
                def builtin47; end

                sig { returns(::BigDecimal) }
                def builtin48; end

                sig { returns(::Array) }
                def builtin49; end

                sig { returns(::T::Hash[::T.untyped, ::T.untyped]) }
                def builtin50; end

                sig { returns(::NilClass) }
                def builtin51; end

                sig { returns(::Symbol) }
                def builtin52; end

                sig { returns(::Date) }
                def builtin53; end

                sig { returns(::DateTime) }
                def builtin54; end

                sig { returns(::ActiveSupport::TimeWithZone) }
                def builtin55; end

                sig { returns(::BigDecimal) }
                def builtin56; end

                sig { returns(::Array) }
                def builtin57; end

                sig { returns(::T::Hash[::T.untyped, ::T.untyped]) }
                def builtin58; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin59; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin60; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin61; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin62; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin63; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin64; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin65; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin66; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin67; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin68; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin69; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin70; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin71; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin72; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin73; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin74; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin75; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin76; end

                sig { returns(::T.any(::Dry::Monads::Maybe::Some, ::Dry::Monads::Maybe::None)) }
                def builtin77; end
              end
            RBI

            assert_equal(expected, rbi_for(:ExampleBuiltin))
          end

          it "generates correct RBI file for adbanced types" do
            add_ruby_file("example_adbanced.rb", <<~RUBY)
              class ExampleAdbanced < ::Dry::Struct
                Dry::Types.load_extensions(:maybe)
                Dry::Types.load_extensions(:monads)

                module Types
                  include ::Dry.Types()
                end

                class Fooo < ::Dry::Struct
                  attribute :string, Types::String
                end

                attribute? :attr01, Types.Instance(Fooo)
                attribute? :attr02, Types.Instance(::Range)
                attribute? :attr03, Types.Instance(::Set)

                attribute? :attr04, Types.Constructor(Fooo)
                attribute? :attr05, Types.Constructor(::Range)
                attribute? :attr06, Types.Constructor(::Set)

                attribute? :attr07, Types.Interface(:call).optional

                attribute? :attr08, Types::Hash.schema(name: Types::String, age: Types::Coercible::Integer)

                attribute  :attr09, Types::Nil | Types::String | Types::Integer
                attribute  :attr10, Types::Nil | Types.Array(Types::String) | Types.Array(Types::Integer)

                attribute  :attr11, Types.Array(Types::String)
                attribute? :attr12, Types.Array(Types::String)
                attribute? :attr13, Types.Array(Types::String.optional)
                attribute  :attr14, Types.Array(Fooo)
                attribute  :attr15, Types.Array(Types.Constructor(Fooo))
                attribute  :attr16, Types.Array(Types::Nil | Types::String | Types::Integer)
                attribute  :attr17, Types.Array(Types.Array(Types::Nil | Types::String | Types::Integer))
              end
            RUBY

            expected = <<~RBI
              # typed: strong

              class ExampleAdbanced
                sig { returns(::T.nilable(::ExampleAdbanced::Fooo)) }
                def attr01; end

                sig { returns(::T.nilable(::T::Range[::T.untyped])) }
                def attr02; end

                sig { returns(::T.nilable(::T::Set[::T.untyped])) }
                def attr03; end

                sig { returns(::T.nilable(::ExampleAdbanced::Fooo)) }
                def attr04; end

                sig { returns(::T.nilable(::T::Range[::T.untyped])) }
                def attr05; end

                sig { returns(::T.nilable(::T::Set[::T.untyped])) }
                def attr06; end

                sig { returns(::T.untyped) }
                def attr07; end

                sig { returns(::T.nilable(::T::Hash[::T.untyped, ::T.untyped])) }
                def attr08; end

                sig { returns(::T.nilable(::T.any(::String, ::Integer))) }
                def attr09; end

                sig { returns(::T.nilable(::T.any(::T::Array[::String], ::T::Array[::Integer]))) }
                def attr10; end

                sig { returns(::T::Array[::String]) }
                def attr11; end

                sig { returns(::T.nilable(::T::Array[::String])) }
                def attr12; end

                sig { returns(::T.nilable(::T::Array[::T.nilable(::String)])) }
                def attr13; end

                sig { returns(::T::Array[::ExampleAdbanced::Fooo]) }
                def attr14; end

                sig { returns(::T::Array[::ExampleAdbanced::Fooo]) }
                def attr15; end

                sig { returns(::T::Array[::T.nilable(::T.any(::String, ::Integer))]) }
                def attr16; end

                sig { returns(::T::Array[::T::Array[::T.nilable(::T.any(::String, ::Integer))]]) }
                def attr17; end
              end
            RBI
            assert_equal(expected, rbi_for(:ExampleAdbanced))
          end
        end
      end
    end
  end
end
