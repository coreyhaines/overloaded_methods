# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "overloaded_methods/version"

Gem::Specification.new do |s|
  s.name        = "overloaded_methods"
  s.version     = OverloadedMethods::VERSION
  s.authors     = ["Corey Haines", "Josh Cheek"]
  s.email       = ["coreyhaines@gmail.com", "josh.cheek@gmail.com"]
  s.homepage    = "https://github.com/coreyhaines/overloaded_methods"
  s.summary     = %q{Bringing the power of predicate-based method dispatch to Ruby, where it belongs!}
  s.description = %q{Single clause, branching method definitions are so 2007. Get with SRP and party! With overloaded_methods, you can separate out any conditional branching in your method to where it belongs: predicates! Feel the power of the chain-of-responsibility pattern in your own code!!!!!!}
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "codeclimate-test-reporter", "~> 0.4.5"
  s.add_development_dependency "simplecov", "~> 0.9.1"

  s.post_install_message = <<'Omg, frogs <3'.gsub(/(gg+)/) { |capture| "\e[32m#{capture.gsub 'g', '.'}\e[0m" }.gsub("brown", "\e[33m").gsub("off", "\e[0m")
              .7
     .      .M
      .  . .N
      M.  ..O
     =. .. .M
     N . .  .N
      O.. . . O
        MN:. . M
           OM...N
             N .OM                 brown.NM8MMMMMMoff
             O ..N             brown...MM=:Z7?Z7??MMMMIMMOM8Noff
             M...O        brown,MMMMMMMMMM$$:=ZZ$~:$?7ZMMMMM8?Moff
           .N .  M       brownMMI$7:==?:77MMMM7$O~+~ZO~~I=7ZMMMMoff
           O$...N        brownM=$ZZI=MMM7ZZI=?MMZ+:$I?8Z~?ZO~=ZIMMoff
        .MN ...O         brownM~?Z==ZZZ=MM$$=$ZZMMO=~~?$=$Z~~OO+=MMoff
        OM ...,M      DAAAAAAAAAAAAAAAAAAAAAAAMbrown=Z=+OOI=+ZO$O+MMoff
      NOM.. . N     DAAAAAAAAAAAAM?:DAAAAAAAAAAAAMbrown$ZZ?$+IZ7+8?M8off
     NOM.....O     DAAAAAAAAM:ggggDAAAAAAAAAAAAAAMbrown78OI+D=78=$MMoff
    NO.. ...MN     DAAAAAAAMgggggggDAAAAAAAAAAAAAM,MMbrownMO7?I8Z7OMoff
   MN.... ..O       DAAAAAMgggggggggDAAAAAAAAAAAAMgg~MMbrown?NMM7O8MMoff
  NOM..  ..MN        DAAMggggggggggggDAAAAAAAAAAMgggggggMMbrown7.MMMoff
 NOM.. .. .OM         MggggggggggggggggDAAAAAAAMgggggggggggMM:M
 NOM. .. ..NO        Mggggggggggggggggggg~DAAMggggggggggggggI,,M
 NOM.. .. .MN       MMgggbrownZMMMMMMoffggggggggggggggggggggggggggggg=MM
 NOM. . ... O       MggbrownMMMNMMMMMMMMZoffgggggggggggggggggggggggggg$MI
 NOM8.. .. .MM      MZbrownMMMMMMMMMMMMMMMoffgggggggggM~gggggggggggggggMM
  NOM .. . . NOM    Mgggggggggggggggggggggggg8M$ggggggggggggggggMM
   NOMO. . . . .    M.MMMMMMMMMMMMNMMMMNMMMMMMggggggggggggggggggMM,
     NOMM8.  .     M:MM  MMggggggggggggggggggggggggggggggggggggggMM
           .    .MMMM     brownMMMMgggggggggggggbrown7ZMMggggggggggggggggggMM
               .MNOM      brownMMMMMMMMMMMMMMMMMMMggggggggggggggggggggOMM
                 H         brownMMMMMMMMMMMMMMMMMggggggg,ggggggggggggggMM
                            brownMMMMMMMMMMMM=gggggggggMMggggggggggggggMMN
                              brown:MMMMggggggggggggggggMgggggggMggggggMMM
                                 MMMggggggggggggggMNggggg:7gggggggMMM .MMMMMM
                                 MMMMgggggggggMgggMgggggMgggggggggMMMMggggggMM
                                 MggMMMgggggggMgggMgggg=IggggggggMMgggggggggM
                                 MggMMMMgggggMggggMggggMgggggMMM:ggggggggggMM
                                MMggM  MMMgggMgggMMgggMggggMMMgggggggggggggM,
                               .MggMM   MMMMMMgggMggggMgggggggggggggggggggMM
                       ggMMMMMMMMggM   MggMMMgggMMgggOMggggggggggggggMNggMM
                     MgggggggggggggM  MMMggMMgggMMMMMMMgggggggggggggMgg+MM
                     :MM7ggggMggIMM  D ggM?MgggMM     MgggggggggggMMggMM,
                          .MggMgg    ggg gM+gggM      NMggggggggMMMggMM
                                  .MM+gZMMgggggM       MMMMMMMMMMggggM
                                  MIgg8MM,ggggMM           .MMMggMggM
                                 MMMgggMMMMggMI       ggOMMMggOMMggMM
                                MgggMDggggM M        MgggggNMMggMMggM
                                MMMMgggggM ggM      .M:gggMggggMggggM
                                           MM          MMMMggggggMMMI
Omg, frogs <3
end
