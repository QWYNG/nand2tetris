# frozen_string_literal: true

module Assembler
  class Parser
    attr_reader :command

    def initialize
      @file = File.open ARGV[0]
    end

    def run
      @file.readlines(chomp: true).each do |line|
        command = parse(line)
        case command
        when A_COMMAND
          hack = sprintf("%#016b", command.symbol.to_i)
        when C_COMMAND
          hack = '111' + Code.comp(command.comp) + Code.dest(command.dest) + Code.jump(command.jump)
        else
          next
        end

        File.open('result.hack', 'a') do |f|
          f.puts(hack + "\n")
        end
      end
    end

    def parse(line)
      if line[0] == '@'
        A_COMMAND.new(line)
      elsif line[0] == '/' && line[1] == '/' or line.empty?
        nil
      else
        C_COMMAND.new(line)
      end
    end
  end
end
