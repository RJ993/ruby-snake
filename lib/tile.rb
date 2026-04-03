# Places where the player can move (and walls where they can't).
class Tile
  attr_accessor :content_display, :content

  def initialize(content_display)
    @content = nil
    @content_display = content_display
  end

  def to_s
    @content_display
  end

  def change_content(new_content, new_display)
    @content = new_content
    @content_display = new_display
  end

  def revert_content
    @content = nil
    @content_display = "   "
  end
end