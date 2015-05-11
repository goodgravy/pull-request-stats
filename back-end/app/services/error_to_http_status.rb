class ErrorToHttpStatus
  def self.[](error)
    new(error).execute
  end

  def initialize(error)
    @error = error
  end

  def execute
    result = if error.inspect =~ /NoBrainer/
               no_brainer
             end

    result || 500
  end

  private

  attr_reader :error

  def no_brainer
    case error.class.to_s
    when 'NoBrainer::Error::DocumentNotFound'
      404
    end
  end
end
