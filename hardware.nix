{ config, pkgs, ... }:

{
  # Update the CPU microcode for Intel processors.
  hardware.cpu.intel.updateMicrocode = true;

  # Enabling PipeWire.
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable OpenCL support.
  hardware.opengl.extraPackages = [ intel-compute-runtime ];

  # Enable Font/DPI configuration optimized for HiDPI displays.
  hardware.video.hidpi.enable = true;

  # Enable the TLP power management daemon.
  services.tlp.enable = true;
}
