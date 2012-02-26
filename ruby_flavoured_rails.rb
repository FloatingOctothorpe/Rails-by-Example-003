#!/usr/bin/ruby
#
# Learn Rails by Example - Chapter 4 exercises

# 1
def string_shuffle(s)
  s.split('').shuffle().join()
end
puts(string_shuffle("foobar"))

# 2
class String
  def shuffle
    self.split('').shuffle().join()
  end
end
puts('foobar'.shuffle)

# 3
person1 = {
  :first => 'John',
  :last => 'Doe',
}
person2 = {
  :first => 'Jane',
  :last => 'Roe',
}
person3 = {
  :first => 'Richard',
  :last => 'Roe',
}
params = {
  :father => person1,
  :mother => person2,
  :child => person3,
}
puts(params[:father][:first])