#-------------------------------------------------------------------------------
# Copyright (c) 2013 Gilad Naaman.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the GNU Public License v3.0
# which accompanies this distribution, and is available at
# http://www.gnu.org/licenses/gpl.html
# 
# Contributors:
#     Gilad Naaman - initial API and implementation
#-------------------------------------------------------------------------------


#--------------------------------
# Roles
#--------------------------------
admins = Role.create do |r|    # Admins
  r.name = 'Administration'
  r.groupname = 'Administrators'
  r.adjective = 'Admin'
  r.is_admin = true
  r.color = '#00ff00'
end
mods = Role.create do |r|    # Moderators
  r.name = 'Moderation'
  r.groupname = 'Moderators'
  r.adjective = 'Moderator'
  r.is_moderator = true
  r.color = '#0000ff'
end
regs = Role.create do |r|    # Regular Users
  r.name = ''
  r.groupname = 'Regular Users'
  r.adjective = 'User'
end

#--------------------------------
# Users
#--------------------------------
admin = User.create do |u|    # Example Admin
  u.username = "Admin"
  u.first_name = "Admino"
  u.last_name = "Admini"  # He's Italian.
  u.email = "admin@example.com"
  u.password = u.password_confirmation = "admino"
  u.role = admins
end
admin.save
mod = User.create do |u|    # Example Moderator
  u.username = "Moderator"
  u.first_name = "Amy"
  u.last_name = "Pond"
  u.email = "amy.pond@example.com"
  u.password = u.password_confirmation = "amypond"
  u.role = mods
end
reg = User.create do |u|    # Example Admin
  u.username = "Gilnaa"
  u.first_name = "Gilad"
  u.last_name = "Naaman"  # He's Italian.
  u.email = "gilad.doom@gmail.com"
  u.password = u.password_confirmation = "javasucks"
  u.role = regs
end

#--------------------------------
# Categories & Forums
#--------------------------------
c1 = Category.create do |c|
  c.name = "First Category"
  c.description = "Some vague description."
end
c2 = Category.create do |c|
  c.name = "Second Category"
  c.description = "Some more vague description."
end

4.times do |i|
  Forum.create do |f|
    f.name = "Forum No' #{i + 1}"
    f.category = c1
  end
end
4.times do |i|
  Forum.create do |f|
    f.name = "Forum No' #{i + 5}"
    f.category = c2
  end
end

#--------------------------------
# Topics & Comments
#--------------------------------
t1 = Topic.create do |t|
  t.title = "First Topic"
  t.body = "Silence in the library!"
  t.forum = c1.forums.first
  t.author = User.first
end
c1 = Comment.create do |c|
  c.author = mod
  c.topic = t1
  c.body = "Potato"
end