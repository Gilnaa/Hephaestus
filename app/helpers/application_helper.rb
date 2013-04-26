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
module ApplicationHelper
  def comment_exists?(id)
    unless Comment.exists? id
      flash[:error] = "Could not find a comment with an ID of #{id}"
      redirect_to forums_path
      false
    else
      true
    end
  end
  def topic_exists?(id)
    unless Topic.exists? id
      flash[:error] = "Could not find a topic with an ID of #{id}"
      redirect_to forums_path
      false
    else
      true
    end
  end
  def forum_exists?(id)
    unless Forum.exists? id
      flash[:error] = "Could not find a forum with an ID of #{id}"
      redirect_to forums_path
      false
    else
      true
    end
  end
end
