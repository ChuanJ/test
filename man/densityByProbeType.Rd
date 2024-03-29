\name{densityByProbeType}
\alias{densityByProbeType}
\title{
Plot the beta value distributions of the Infinium I and II probe types 
relative to the overall beta value distribution. 
}
\description{
Plot the overall density distribution of beta values and the density 
distributions of the Infinium I and II probe types.
}
\usage{
densityByProbeType(data, legendPos = "top", colors = c("black", "red", "blue"), 
main = "", lwd = 3, cex.legend = 1)
}
\arguments{
  \item{data}{A \code{MethylSet} or a \code{matrix} or a \code{vector}.
    We either use the \code{getBeta} function to get Beta values (in the
    first case) or we assume the matrix or vector contains Beta values.}
  \item{legendPos}{The x and y co-ordinates to be used to position the
    legend. They can be specified by keyword or in any way which is
    accepted by \code{\link[grDevices]{xy.coords}}. See
    \code{\link[graphics]{legend}} for details.} 
  \item{colors}{Colors to be used for the different beta value density
    distributions. Must be a vector of length 3.} 
  \item{main}{Plot title.}
  \item{lwd}{The line width to be used for the different beta value
    density distributions.} 
  \item{cex.legend}{The character expansion factor for the legend text.}
}
\details{
  The density distribution of the beta values for a single sample is
  plotted. The density distributions of the Infinium I and II probes are
  then plotted individually, showing how they contribute to the overall
  distribution. This is useful for visualising how using
  \code{\link{SWAN}} affects the data.
}
\references{
No return value. Plot is produced as a side-effect.
}
\author{
Jovana Maksimovic \email{jovana.maksimovic@mcri.edu.au}.
}

\seealso{
 \code{\link{densityPlot}}, \code{\link{densityBeanPlot}},
  \code{\link[graphics]{par}}, \code{\link[graphics]{legend}}
}
\examples{
if (require(minfi) & require(minfiData)) {
  dat <- preprocessRaw(RGsetEx)
  datSwan <- SWAN(dat)
  par(mfrow=c(1,2))
  densityByProbeType(dat[,1], main="Raw")
  densityByProbeType(datSwan[,1], main="SWAN")
}
}

