Feature: Developer generates a named constructor
  As a Developer
  I want to automate creating named constructor
  In order to avoid repetitive tasks and interruptions in development flow

  Scenario: Generating a named constructor in an empty class
  Given the spec file "spec/CodeGeneration/NamedConstructor/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\NamedConstructor;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
  And the class file "src/CodeGeneration/NamedConstructor/User.php" contains:
    """
    <?php

    namespace CodeGeneration\NamedConstructor;

    class User
    {
    }

    """
  When I run phpspec and answer "y" when asked if I want to generate the code
  Then the class in "src/CodeGeneration/NamedConstructor/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\NamedConstructor;

    class User
    {
        public static function register($argument1, $argument2)
        {
            $user = new User();

            // TODO: write logic here

            return $user;
        }
    }

    """

  Scenario: Generating a named constructor with more arguments than an existing constructor accepts
  Given the spec file "spec/CodeGeneration/NamedConstructor/TooManyArguments/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\NamedConstructor\TooManyArguments;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
  And the class file "src/CodeGeneration/NamedConstructor/TooManyArguments/User.php" contains:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\TooManyArguments;

    class User
    {
        public function __construct()
        {
        }
    }

    """
  When I run phpspec and answer "y" when asked if I want to generate the code
  Then the class in "src/CodeGeneration/NamedConstructor/TooManyArguments/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\TooManyArguments;

    class User
    {
        public function __construct()
        {
        }

        public static function register($argument1, $argument2)
        {
            throw new \BadMethodCallException("Mismatch between the number of arguments of the factory method and constructor");
        }
    }

    """

  Scenario: Generating a named constructor with less arguments than an existing constructor accepts
  Given the spec file "spec/CodeGeneration/NamedConstructor/TooFewArguments/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\NamedConstructor\TooFewArguments;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
  And the class file "src/CodeGeneration/NamedConstructor/TooFewArguments/User.php" contains:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\TooFewArguments;

    class User
    {
        public function __construct($argument1, $argument2, $argument3)
        {
        }
    }

    """
  When I run phpspec and answer "y" when asked if I want to generate the code
  Then the class in "src/CodeGeneration/NamedConstructor/TooFewArguments/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\TooFewArguments;

    class User
    {
        public function __construct($argument1, $argument2, $argument3)
        {
        }

        public static function register($argument1, $argument2)
        {
            throw new \BadMethodCallException("Mismatch between the number of arguments of the factory method and constructor");
        }
    }

    """

  Scenario: Generating a named constructor with a matching number of constructor arguments
    Given the spec file "spec/CodeGeneration/NamedConstructor/EqualArguments/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\NamedConstructor\EqualArguments;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
    And the class file "src/CodeGeneration/NamedConstructor/EqualArguments/User.php" contains:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\EqualArguments;

    class User
    {
        public function __construct($argument1, $argument2)
        {
        }
    }

    """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/CodeGeneration/NamedConstructor/EqualArguments/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\EqualArguments;

    class User
    {
        public function __construct($argument1, $argument2)
        {
        }

        public static function register($argument1, $argument2)
        {
            $user = new User($argument1, $argument2);

            // TODO: write logic here

            return $user;
        }
    }

    """

  Scenario: Generating a named constructor with the correct number of required constructor arguments
  Given the spec file "spec/CodeGeneration/NamedConstructor/OptionalArguments/UserSpec.php" contains:
    """
    <?php

    namespace spec\CodeGeneration\NamedConstructor\OptionalArguments;

    use PhpSpec\ObjectBehavior;
    use Prophecy\Argument;

    class UserSpec extends ObjectBehavior
    {
        function it_registers_a_user()
        {
            $this->beConstructedThrough('register', array('firstname', 'lastname'));
            $this->getFirstname()->shouldBe('firstname');
        }
    }

    """
  And the class file "src/CodeGeneration/NamedConstructor/OptionalArguments/User.php" contains:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\OptionalArguments;

    class User
    {
        public function __construct($argument1, $argument2, $argument3 = 'optional')
        {
        }
    }

    """
  When I run phpspec and answer "y" when asked if I want to generate the code
  Then the class in "src/CodeGeneration/NamedConstructor/OptionalArguments/User.php" should contain:
    """
    <?php

    namespace CodeGeneration\NamedConstructor\OptionalArguments;

    class User
    {
        public function __construct($argument1, $argument2, $argument3 = 'optional')
        {
        }

        public static function register($argument1, $argument2)
        {
            $user = new User($argument1, $argument2);

            // TODO: write logic here

            return $user;
        }
    }

    """

  Scenario: Generating a named constructor using beConstructedThrough*
    Given the spec file "spec/CodeGeneration/ShortSyntax/UserSpec.php" contains:
      """
      <?php

      namespace spec\CodeGeneration\ShortSyntax;

      use PhpSpec\ObjectBehavior;
      use Prophecy\Argument;

      class UserSpec extends ObjectBehavior
      {
          function it_registers_a_user()
          {
              $this->beConstructedThroughRegister('firstname', 'lastname');
              $this->getFirstname()->shouldBe('firstname');
          }
      }

      """
    And the class file "src/CodeGeneration/ShortSyntax/User.php" contains:
      """
      <?php

      namespace CodeGeneration\ShortSyntax;

      class User
      {
      }

      """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/CodeGeneration/ShortSyntax/User.php" should contain:
      """
      <?php

      namespace CodeGeneration\ShortSyntax;

      class User
      {
          public static function register($argument1, $argument2)
          {
              $user = new User();

              // TODO: write logic here

              return $user;
          }
      }

      """

  Scenario: Generating a named constructor using beConstructed*
    Given the spec file "spec/CodeGeneration/ShortSyntax2/UserSpec.php" contains:
      """
      <?php

      namespace spec\CodeGeneration\ShortSyntax2;

      use PhpSpec\ObjectBehavior;
      use Prophecy\Argument;

      class UserSpec extends ObjectBehavior
      {
          function it_registers_a_user()
          {
              $this->beConstructedFromString('firstname', 'lastname');
              $this->getFirstname()->shouldBe('firstname');
          }
      }

      """
    And the class file "src/CodeGeneration/ShortSyntax2/User.php" contains:
      """
      <?php

      namespace CodeGeneration\ShortSyntax2;

      class User
      {
      }

      """
    When I run phpspec and answer "y" when asked if I want to generate the code
    Then the class in "src/CodeGeneration/ShortSyntax2/User.php" should contain:
      """
      <?php

      namespace CodeGeneration\ShortSyntax2;

      class User
      {
          public static function fromString($argument1, $argument2)
          {
              $user = new User();

              // TODO: write logic here

              return $user;
          }
      }

      """

  Scenario: Generating the private constructor
    Given the spec file "spec/CodeGeneration/PrivateConstructor/UserSpec.php" contains:
      """
      <?php

      namespace spec\CodeGeneration\PrivateConstructor;

      use PhpSpec\ObjectBehavior;
      use Prophecy\Argument;

      class UserSpec extends ObjectBehavior
      {
          function it_registers_a_user()
          {
              $this->beConstructedThrough('register', array('firstname', 'lastname'));
              $this->getFirstname()->shouldBe('firstname');
          }
      }

      """
    And the class file "src/CodeGeneration/PrivateConstructor/User.php" contains:
      """
      <?php

      namespace CodeGeneration\PrivateConstructor;

      class User
      {
      }

      """
    When I run phpspec and answer "y" to both questions
    Then the class in "src/CodeGeneration/PrivateConstructor/User.php" should contain:
      """
      <?php

      namespace CodeGeneration\PrivateConstructor;

      class User
      {
          private function __construct()
          {
          }

          public static function register($argument1, $argument2)
          {
              $user = new User();

              // TODO: write logic here

              return $user;
          }
      }

      """

  Scenario: Generating multiple named constructors at once
    Given the spec file "spec/CodeGeneration/PrivateConstructor/AgeSpec.php" contains:
      """
      <?php

      namespace spec\CodeGeneration\PrivateConstructor;

      use PhpSpec\ObjectBehavior;
      use Prophecy\Argument;

      class AgeSpec extends ObjectBehavior
      {
          function it_is_constructed_from_string()
          {
              $this->beConstructedFromString('30');
              $this->getAge()->shouldReturn(30);
          }

          function it_is_constructed_from_integer()
          {
              $this->beConstructedFromInteger(30);
              $this->getAge()->shouldReturn(30);
          }
      }

      """
    And the class file "src/CodeGeneration/PrivateConstructor/Age.php" contains:
      """
      <?php

      namespace CodeGeneration\PrivateConstructor;

      class Age
      {
      }

      """
    When I run phpspec and answer "y" to the three questions
    Then I should not be prompted for more questions
    And the class in "src/CodeGeneration/PrivateConstructor/Age.php" should contain:
      """
      <?php

      namespace CodeGeneration\PrivateConstructor;

      class Age
      {
          private function __construct()
          {
          }

          public static function fromInteger($argument1)
          {
              $age = new Age();

              // TODO: write logic here

              return $age;
          }

          public static function fromString($argument1)
          {
              $age = new Age();

              // TODO: write logic here

              return $age;
          }
      }

      """
