Pod::Spec.new do |s|

  s.name         = 'EllipticCurve'
  s.version      = '0.3.3'
  s.summary      = 'ECDSA in pure Swift'

  s.description  = <<-DESC
                  Elliptic Curve Digital Signing Algorithms in pure Swift
                   DESC

  s.homepage     = 'https://github.com/hyugit/EllipticCurve.git'
  s.license      = 'MIT'
  s.authors      = { 'Huang Yu' => 'pod@trave7er.com', 'Alexander Cyon' => 'alex.cyon@gmail.com' }
  s.source = { :git => 'https://github.com/hyugit/EllipticCurve.git' }
  s.source_files = 'Sources/**/*.swift'
  s.swift_version = '4.1.2'
  s.dependency 'UInt256', '~> 0.2.2'
  s.ios.deployment_target = '11.2'
  s.macos.deployment_target = '10.12'
end
