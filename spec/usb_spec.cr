require "./spec_helper"

describe USB do
end

describe USB::LibUSBError do
  it "constructs specific subclasses for LibUSB::Error types" do
    USB::LibUSBError.for(LibUSB::Error::IO).is_a?(USB::IOError)
    USB::LibUSBError.for(LibUSB::Error::INVALID_PARAM).is_a?(USB::InvalidParamError)
    USB::LibUSBError.for(LibUSB::Error::ACCESS).is_a?(USB::AccessError)
    USB::LibUSBError.for(LibUSB::Error::NO_DEVICE).is_a?(USB::NoDeviceError)
    USB::LibUSBError.for(LibUSB::Error::NOT_FOUND).is_a?(USB::NotFoundError)
    USB::LibUSBError.for(LibUSB::Error::BUSY).is_a?(USB::BusyError)
    USB::LibUSBError.for(LibUSB::Error::TIMEOUT).is_a?(USB::TimeoutError)
    USB::LibUSBError.for(LibUSB::Error::OVERFLOW).is_a?(USB::OverflowError)
    USB::LibUSBError.for(LibUSB::Error::PIPE).is_a?(USB::PipeError)
    USB::LibUSBError.for(LibUSB::Error::INTERRUPTED).is_a?(USB::InterruptedError)
    USB::LibUSBError.for(LibUSB::Error::NO_MEM).is_a?(USB::NoMemoryError)
    USB::LibUSBError.for(LibUSB::Error::NOT_SUPPORTED).is_a?(USB::NotSupportedError)
  end
end
