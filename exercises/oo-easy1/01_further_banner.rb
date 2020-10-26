require "pry"
class Banner
  MIN_BANNER_WIDTH = 5
  MAX_BANNER_WIDTH = 80
  SPACING = 5
  MAX_LINE_LENGTH = MAX_BANNER_WIDTH - SPACING

  def initialize(message, input_width = nil)
    raise ArgumentError, display_width_error unless proper_width?(input_width)

    if input_width.nil?
      @message_lines = chop(message, MAX_LINE_LENGTH)
    else
      @message_lines = chop(message, input_width)
    end
    @width = max_line_length(@message_lines)
  end

  def to_s
    [horizontal_rule, empty_line, parse_message(@message_lines), empty_line, horizontal_rule].join("\n")
  end

  private

  def need_to_chop?(message, max_length)
    message.length > max_length
  end

  def proper_width?(width)
    width.nil? || (MIN_BANNER_WIDTH..MAX_BANNER_WIDTH).include?(width)
  end

  def display_width_error
    "Width must be between #{MIN_BANNER_WIDTH} and #{MAX_BANNER_WIDTH}"
  end

  def chop(message, length)
    return [message] if message.length < length

    message_lines = []
    current_line = []

    message.split.each do |word|
      current_line_length = (current_line + [word]).join(' ').size

      if current_line_length < length
        current_line.push(word)
      else
        message_lines.push(current_line.join(' '))
        current_line = []
        current_line.push(word)
      end
    end
    message_lines.push(current_line.join(' ')) unless current_line.empty?
  end

  def max_line_length(message_lines)
    message_lines.max_by(&:size).length
  end

  def empty_line
    "| #{' ' * @width} |"
  end

  def horizontal_rule
    "+-#{'-' * @width}-+"
  end

  def center_line(line)
    "| #{line.center(@width)} |"
  end

  def parse_message(message_lines)
    result = []

    message_lines.each do |line|
      result.push(center_line(line))
    end

    result.join("\n")
  end
end

banner = Banner.new('')
puts banner

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
