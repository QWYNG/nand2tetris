module Assembler

  class A_COMMAND
    attr_reader :symbol
    def initialize(command)
      @symbol = command[1..] # 2.7.0 is god
    end
  end

  class C_COMMAND
    DEST_SIGN = '='
    JUMP_SIGN = ';'

    attr_reader :dest, :comp, :jump
    def initialize(command)
      parse(command)
    end

    private

    def parse(command)
      if command.include?(DEST_SIGN)
        parsed = command.split(DEST_SIGN, 2)
        @dest = parsed[0]
        return parse(parsed[1])
      end

      if command.include?(JUMP_SIGN)
        parsed = command.split(JUMP_SIGN, 2)

        @jump = parsed[1]
        return parse(parsed[0])
      end

      @comp = command
    end
  end
end
