module USB

  class Error < Exception
  end

  private module LibUSBErrorType
  end

  class LibUSBError < Error
    protected def initialize(error_code : Int32, message : String = "")
      raise ArgumentError.new("invalid error code: #{error_code}") unless error_code < 0
      @error_code = error_code
      super(message)
    end

    def error_code : Int32
      @error_code
    end


  end


  macro lib_usb_error(name, err_code)
    class {{name}} < LibUSBError
      include LibUSBErrorType
      def initialize(message : String)
        super({{err_code}}.value, message)
      end
    end
  end

  lib_usb_error IOError, LibUSB::Error::IO
  lib_usb_error InvalidParamError, LibUSB::Error::INVALID_PARAM
  lib_usb_error AccessError, LibUSB::Error::ACCESS
  lib_usb_error NoDeviceError, LibUSB::Error::NO_DEVICE
  lib_usb_error NotFoundError, LibUSB::Error::NOT_FOUND
  lib_usb_error BusyError, LibUSB::Error::BUSY
  lib_usb_error TimeoutError, LibUSB::Error::TIMEOUT
  lib_usb_error OverflowError, LibUSB::Error::OVERFLOW
  lib_usb_error PipeError, LibUSB::Error::PIPE
  lib_usb_error InterruptedError, LibUSB::Error::INTERRUPTED
  lib_usb_error NoMemoryError, LibUSB::Error::NO_MEM
  lib_usb_error NotSupportedError, LibUSB::Error::NOT_SUPPORTED


  class LibUSBError < Error
    def self.for(error_code : Int, message : String = "")
      if code = LibUSB::Error.from_value? error_code
        for(code, message)
      else
        LibUSBError.new(error_code, message)
      end
    end

    def self.for(error_code : LibUSB::Error, message : String = "")
      case error_code
      when .io?
        IOError.new(message)
      when .invalid_param?
        InvalidParamError.new(message)
      when .access?
        AccessError.new(message)
      when .no_device?
        NoDeviceError.new(message)
      when .not_found?
        NotFoundError.new(message)
      when .busy?
        BusyError.new(message)
      when .timeout?
        TimeoutError.new(message)
      when .overflow?
        OverflowError.new(message)
      when .pipe?
        PipeError.new(message)
      when .interrupted?
        InterruptedError.new(message)
      when .no_mem?
        NoMemoryError.new(message)
      when .not_supported?
        NotSupportedError.new(message)
      else
        raise ArgumentError.new("unrecognized error_code: #{error_code}")
      end
    end
  end
end
