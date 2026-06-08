draw_tennis_court <- function(major="wimbledon") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 is required for draw_tennis_court()")
  }

  majors <- list(
    wimbledon=list(
      surface="#3E8E41",
      lines="#F5F5F5"
    ),
    roland_garros=list(
      surface="#C65A1E",
      lines="#F2F2F2"
    ),
    us_open=list(
      surface="#1E5AA8",
      lines="#FFFFFF"
    ),
    australian_open = list(
      surface = "#2F9E8F",
      lines   = "#FFFFFF"
    )
  )

  m <- majors[[major]]

  # ------------------------------------------------------------
  # geometry dimensions notes (system is metric)
  #
  # horizontally flipped singles/doubles court
  # coordinate system where:
  #
  # x-axis = court length (baseline to baseline)
  # y-axis = court width (doubles width)
  #
  # official ITF court dimensions:
  # - total court length: 23.77m
  # - total doubles court width: 10.97m
  #
  # reference lines (along x-axis):
  # - baseline at x = 0 and x = 23.77
  # - net position at x ~ 11.885 (midpoint of court length)
  # - service line distance from net: 6.40m service lines at x ~ 5.48 and x ~ 18.28
  #
  # reference lines (along y-axis):
  # - doubles sidelines at y = 0 and y = 10.97
  # - singles sidelines at y ~ 1.37 and y ~ 9.60
  # - center mark divides each baseline at y ~ 5.485
  #
  # small note:
  # i used a small visual padding (-0.3 to 24.07 / -0.3 to 11.27)
  # in the rendering to improve the court aesthetic and avoid
  # clipping of stroke widths, but all tennis geometry is
  # defined in true court coordinates.
  # ------------------------------------------------------------

  ggplot() +

    # surface
    geom_rect(
      aes(
        xmin=-0.3,xmax=24.07,
        ymin=-0.3, ymax=11.27
      ),
      fill=m$surface,
      linewidth=1.2
    ) +

    # net
    geom_segment(aes(x =11.88, xend=11.88, y=0, yend=10.97),linewidth=1,color=m$lines) +

    # baselines
    geom_segment(aes(x=0, xend=0, y=0, yend=10.97),linewidth=1, color=m$lines) +
    geom_segment(aes(x=23.77, xend=23.77, y=0, yend=10.97),linewidth=1, color=m$lines) +

    # singles sideline
    geom_segment(aes(x=0, xend=23.77, y=1.37, yend=1.37),linewidth=1, color=m$lines) +
    geom_segment(aes(x=0, xend=23.77, y=9.6, yend=9.6),linewidth=1, color=m$lines) +

    # doubles sideline
    geom_segment(aes(x=0, xend=23.77, y=10.97, yend=10.97),linewidth=1, color=m$lines) +
    geom_segment(aes(x=0, xend=23.77, y=0, yend=0),linewidth=1, color=m$lines) +

    # center service line
    geom_segment(aes(x=5.48, xend=18.28, y=5.48, yend=5.48),linewidth=1, color=m$lines) +

    # service lines
    geom_segment(aes(x=5.48, xend=5.48, y=1.37, yend=9.6),linewidth=1, color=m$lines) +
    geom_segment(aes(x=18.28, xend=18.28, y=1.37, yend=9.6),linewidth=1, color=m$lines) +

    # center marks
    geom_segment(aes(x=0, xend=0.3, y=5.485, yend=5.485),linewidth=1, color=m$lines) +
    geom_segment(aes(x=23.47, xend=23.77, y=5.485, yend=5.485),linewidth=1, color=m$lines) +

    theme_void()
}
