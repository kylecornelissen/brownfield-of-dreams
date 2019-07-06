# frozen_string_literal: true

class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates :position, numericality: {only_integer: true}
  # validates :position, numericality: {only_integer: true}, if: :next_in_line

  # def next_in_line
  #   binding.pry
  #   vids = tutorial.videos
  #   if vids.empty?
  #     position == 0
  #   else
  #     position == (tutorial.videos.max_by(&:position).position + 1)
  #   end
  # end
end
