require 'rspec'
require './solution'

describe Stream do

  cleansing_examples = [
    ['<!!!>>',                        ''],
    ['<{o"i!a,<{i<a>',                ''],
    ['{{<!>},{<!>},{<!>},{<a>}}',     '{{}}'],
    ['{{<!!>},{<!!>},{<!!>},{<!!>}}', '{{},{},{},{}}'],
    ['{{<a!>},{<a!>},{<a!>},{<ab>}}', '{{}}'],
    ['{{<a>},{<a>},{<a>},{<a>}}',     '{{},{},{},{}}'],
  ]

  cleansing_examples.each do |eg|
    it { expect(subject.process_garbage_and_cancellations(eg[0])).to eql(eg[1]) }
  end

  group_count_examples = [
    ['{}',                        1],
    ['{{{}}}',                    3],
    ['{{},{}}',                   3],
    ['{{{},{},{{}}}}',            6],
    ['{<{},{},{{}}>}',            1],
    ['{<a>,<a>,<a>,<a>}',         1],
    ['{{<a>},{<a>},{<a>},{<a>}}', 5],
    ['{{<!>},{<!>},{<!>},{<a>}}', 2]
  ]

  group_count_examples.each do |eg|
    it { expect(subject.count_groups(eg[0])).to eql(eg[1]) }
  end

  scoring_examples = [
    ['{}',                            1],
    ['{}',                            1],
    ['{{{}}}',                        6],
    ['{{},{}}',                       5],
    ['{{{},{},{{}}}}',               16],
    ['{<a>,<a>,<a>,<a>}',             1],
    ['{{<ab>},{<ab>},{<ab>},{<ab>}}', 9],
    ['{{<!!>},{<!!>},{<!!>},{<!!>}}', 9],
    ['{{<a!>},{<a!>},{<a!>},{<ab>}}', 3]
  ]

  scoring_examples.each do |eg|
    it { expect(subject.calculate_score(eg[0])).to eql(eg[1]) }
  end

  garbage_count_examples = [
    ['<>',                   0],
    ['<random characters>', 17],
    ['<<<<>',                3],
    ['<{!>}>',               2],
    ['<!!>',                 0],
    ['<!!!>>',               0],
    ['<{o"i!a,<{i<a>',      10]
  ]

  garbage_count_examples.each do |eg|
    it { expect(subject.count_garbage(eg[0])).to eql(eg[1]) }
  end
end
