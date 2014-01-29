Terminal paint
==============

How to use
----------

terminal-paint uses ruby >= 2.1 for mandatory named parameters.
It's been released for almost a whole day, so
everyone must have it by now, right? ;)

If you run it as
```
bundle exec ruby paint.rb
```
bundle will check your ruby version for you. If you don't use bundle,
run it manually as `ruby paint.rb`. Or make it executable:
```
chmod +x paint.rb
```
then run as
```
./paint.rb
```

Feedback:
- the very first thing I noticed was that the tests take 1.18s to run, vs 0.01s for JB. That's a warning sign that you're doing something very suboptimal here. I didn't use a profiler and the code looks ok on the surface but there must be something weird going on there. I suspect that this may be because you aren't checking if the edges array already contain the value you're about to add but checking if the element is in an array is expensive, it could be much faster if you used a hash (as far as I remember it has the same access speed regardless of the size). But I'm not sure about this, I didn't test it.
- well done for using guard, it shows you're familiar with it
- it wasn't strictly necessary to break the specs into so many files but if you chose to do it, you should have used all lowercase letters
- well done for using named arguments. It's always a good idea to show during an interview that you're following the latest updates in the field
- Overall this should get you for an interview at Forward. It's not perfect but unless the person reviewing your code is in a particularly bad mood, it should be ok :)