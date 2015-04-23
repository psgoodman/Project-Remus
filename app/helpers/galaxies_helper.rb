module GalaxiesHelper
  def link_systems(system1, system2)
    system1.add_link(system2)
    system2.add_link(system1)
  end

  def build_links(systems_array)
    #Takes in a bunch of systems formatted like the output of
    #build_rings and creates wormhole links between them.

    ringcounter = 0
    systems_array.each do |ring|
      if ringcounter >= 1

        uplink(ring, systems_array[ringcounter - 1])
      end
      crosslink(ring)
      ringcounter += 1
    end
  end

  def find_closest(system, systems_array)
    #takes a single system and an array of system and finds
    #the index of the member of the array with an angle
    #most similar to that of the first system.
    best_angle = 10
    counter = 0
    nominee = nil
    systems_array.each do |candidate|
      best_diff = angle_compare(system.angle, best_angle)
      if angle_compare(candidate.angle, system.angle) < best_diff
        nominee = systems_array[counter]
        best_angle = nominee.angle
      end
      counter +=1
    end
    nominee
  end

  def angle_compare(angle1, angle2)
    diff = (angle2 - angle1).abs
    if diff > 0.5
      diff = (1 - diff).abs
    end
    diff
  end

  def crosslink(ring)
    #generates links within a ring
    links_to_make = 1 + rand(ring.size)/2 + (rand(ring.size)/1.6).round
    until links_to_make <= 0
      origin_system = ring.sample

      target_candidates = ring.reject do |target|

        origin_system.linked_systems.include?(target) || origin_system == target
      end
      target_system = find_closest(origin_system, target_candidates)

      unless target_system == nil
        link_systems(origin_system, target_system)
      end

      links_to_make -= 1
    end
  end

  def uplink(ring, top_ring)
    ring.each do |system|
      # binding.pry
      link_systems(system, find_closest(system, top_ring))
      if rand < 0.35
        target_candidates = top_ring.reject do |target|

          system.linked_systems.include?(target)
        end
        unless target_candidates.empty?
          link_systems(system, find_closest(system, target_candidates))
        end
      end
    end
  end

  def convert_coords(ring, angle, size)
    side_length = 200 * (size + 1)
    complex = Complex.polar(ring, angle*2*Math::PI)
    x = complex.real * 100 + side_length / 2
    y = complex.imag * 100 + side_length / 2
    [x,y]
  end

end
