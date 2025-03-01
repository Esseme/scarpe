# frozen_string_literal: true

# Certain Shoes calls like motion and keydown are basically an
# event subscription, with no other visible presence. However,
# they have a place in the widget tree and can be deleted.
#
# Depending on the display library they may not have any
# direct visual (or similar) presence there either.
#
# Inheriting from Widget gives these a parent slot and a
# linkable_id automatically.
class Shoes::SubscriptionItem < Shoes::Widget
  display_property :shoes_api_name

  def initialize(shoes_api_name:, &block)
    super

    @callback = block

    case shoes_api_name
    when "hover"
      # Hover passes the Shoes widget as the block param
      @unsub_id = bind_self_event("hover") do
        @callback&.call(self)
      end
    when "motion"
      # Shoes sends back x, y, mods as the args.
      # Shoes3 uses the strings "control" "shift" and
      # "control_shift" as the mods arg.
      @unsub_id = bind_self_event("motion") do |x, y, ctrl_key, shift_key, **_kwargs|
        mods = [ctrl_key ? "control" : nil, shift_key ? "shift" : nil].compact.join("_")
        @callback&.call(x, y, mods)
      end
    when "click"
      # Click has block params button, left, top
      # button is the button number, left and top are coords
      @unsub_id = bind_self_event("click") do |button, x, y, **_kwargs|
        @callback&.call(button, x, y)
      end
    else
      raise "Unknown Shoes API call #{shoes_api_name.inspect} passed to SubscriptionItem!"
    end

    @unsub_id = bind_self_event(shoes_api_name) do |*args|
      @callback&.call(*args)
    end

    # This won't create a visible display widget, but will turn into
    # an invisible widget and a stream of events.
    create_display_widget
  end

  def destroy
    # TODO: we need a better way to do this automatically. See https://github.com/scarpe-team/scarpe/issues/291
    unsub_shoes_event(@unsub_id) if @unsub_id
    @unsub_id = nil

    super
  end
end
